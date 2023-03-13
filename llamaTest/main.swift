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

guard let url = URL(string: pathString), url.isFileURL else {
  print("Invalid model path, make sure this is a file URL")
  exit(1)
}

let llama = LlamaRunner(modelURL: url)
llama.run(with: "test")
