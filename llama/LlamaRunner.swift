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

  public enum RunState {
    case notStarted
    case initializing
    case generatingOutput
    case completed
    case failed(error: Error)
  }

  public let modelURL: URL

  private lazy var bridge = _LlamaRunnerBridge(modelPath: modelURL.path)

  public init(modelURL: URL) {
    self.modelURL = modelURL
  }

  public func run(
    with prompt: String,
    config: Config = .default,
    tokenHandler: @escaping (String) -> Void,
    stateChangeHandler: ((RunState) -> Void)? = nil
  ) {
    let _config = _LlamaRunnerBridgeConfig()
    _config.numberOfThreads = config.numThreads
    _config.numberOfTokens = config.numTokens
    _config.reversePrompt = config.reversePrompt

    stateChangeHandler?(.notStarted)

    bridge.run(
      withPrompt: prompt,
      config: _config,
      eventHandler: { event in
        event.match(
          startedLoadingModel: {
            stateChangeHandler?(.initializing)
          },
          finishedLoadingModel: {},
          startedGeneratingOutput: {
            stateChangeHandler?(.generatingOutput)
          },
          outputToken: { token in
            tokenHandler(token)
          },
          completed: {
            stateChangeHandler?(.completed)
          },
          failed: { error in
            stateChangeHandler?(.failed(error: error))
          }
        )
      },
      eventHandlerQueue: DispatchQueue.main
    )
  }
}
