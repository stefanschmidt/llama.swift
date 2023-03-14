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
    public let reversePrompt: String?

    public static let `default` = Config(numThreads: 8, numTokens: 512, reversePrompt: nil)

    public init(numThreads: UInt, numTokens: UInt, reversePrompt: String? = nil) {
      self.numThreads = numThreads
      self.numTokens = numTokens
      self.reversePrompt = reversePrompt
    }
  }

  public let modelURL: URL

  private lazy var bridge = _LlamaRunnerBridge(modelPath: modelURL.path)

  public init(modelURL: URL) {
    self.modelURL = modelURL
  }

  public func run(
    with prompt: String,
    config: Config = .default,
    completion: @escaping () -> Void
  ) {
    let _config = _LlamaRunnerBridgeConfig()
    _config.numberOfThreads = config.numThreads
    _config.numberOfTokens = config.numTokens
    _config.reversePrompt = config.reversePrompt

    bridge.run(
      withPrompt: prompt,
      config: _config,
      eventHandler: { event in
      },
      completion: completion
    )
  }
}
