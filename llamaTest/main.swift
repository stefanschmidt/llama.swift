//
//  main.swift
//  llamaTest
//
//  Created by Alex Rozanski on 12/03/2023.
//

import Foundation
import llama

guard let pathString = Bundle.main.object(forInfoDictionaryKey: "LlamaModelPath") as? String else {
  print("Model path not specified - define in MODEL_PATH")
  exit(1)
}

guard let url = URL(string: pathString), FileManager.default.fileExists(atPath: url.path) else {
  print("Invalid model path, make sure this is a file URL")
  exit(1)
}

// Run Llama

let semaphore = DispatchSemaphore(value: 0)

let llama = LlamaRunner(modelURL: url)
llama.run(
  with: "Building a website can be done in 10 simple steps:",
  completion: {
    semaphore.signal()
  })

while semaphore.wait(timeout: .now()) == .timedOut {
  RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0))
}
