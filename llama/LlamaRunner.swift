//
//  LlamaRunner.swift
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

import Foundation

public class LlamaRunner {
  public let modelURL: URL

  private lazy var bridge = _LlamaRunnerBridge(modelPath: modelURL.path)

  public init(modelURL: URL) {
    self.modelURL = modelURL
  }

  public func run(with prompt: String) {
    bridge.run(withPrompt: prompt)
  }
}
