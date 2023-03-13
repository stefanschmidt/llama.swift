//
//  LlamaRunner.swift
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

import Foundation

public class LlamaRunner {
  public struct Config {
    public let numThreads: UInt
    public let numTokens: UInt

    public static let `default` = Config(numThreads: 8, numTokens: 512)

    public init(numThreads: UInt, numTokens: UInt) {
      self.numThreads = numThreads
      self.numTokens = numTokens
    }
  }

  public let modelURL: URL

  private lazy var bridge = _LlamaRunnerBridge(modelPath: modelURL.path)

  public init(modelURL: URL) {
    self.modelURL = modelURL
  }

  public func run(with prompt: String, config: Config) {
    let _config = _LlamaRunnerBridgeConfig()
    _config.numberOfThreads = config.numThreads
    _config.numberOfTokens = config.numTokens

    bridge.run(withPrompt: prompt, config: _config)
  }
}
