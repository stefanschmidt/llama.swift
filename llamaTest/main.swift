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

func run() {
  while true {
    var prompt: String?

    while((prompt?.count ?? 0) == 0) {
      print("Enter prompt: ")
      prompt = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    let semaphore = DispatchSemaphore(value: 0)

    let llama = LlamaRunner(modelURL: url)
    llama.run(
      with: prompt!,
      tokenHandler: { token in
        print(token, terminator: "")
      },
      stateChangeHandler: { state in
        switch state {
        case .notStarted:
          break
        case .initializing:
          print("Initializing model... ", terminator: "")
        case .generatingOutput:
          print("Done.")
          print("")
          print("Generating output...")
          print("\"", terminator: "")
        case .completed:
          print("\"")
          print("")
          semaphore.signal()
        case .failed(error: let error):
          print("")
          print("Failed to generate output: ", error.localizedDescription)
        }
      })

    while semaphore.wait(timeout: .now()) == .timedOut {
      RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0))
    }
  }
}

run()
