# llama.swift

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A fork of @ggerganov's llama.cpp to use [Facebook's LLaMA](https://github.com/facebookresearch/llama) in Swift.

## Description

See the [main repository](https://github.com/ggerganov/llama.cpp/) for info about the C++ implementation.

## Setup

Here are the step for the LLaMA-7B model:

```bash
# build this repo
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp
make

# obtain the original LLaMA model weights and place them in ./models
ls ./models
65B 30B 13B 7B tokenizer_checklist.chk tokenizer.model

# install Python dependencies
python3 -m pip install torch numpy sentencepiece

# convert the 7B model to ggml FP16 format
python3 convert-pth-to-ggml.py models/7B/ 1

# quantize the model to 4-bits
./quantize.sh 7B

# run the inference
./main -m ./models/7B/ggml-model-q4_0.bin -t 8 -n 128
```

When running the larger models, make sure you have enough disk space to store all the intermediate files.

## Usage

```swift
let url = ... // URL to the model file, as per llama.cpp
let llama = LlamaRunner(modelURL: url)

llama.run(
  with: "Building a website can be done in 10 simple steps:",
  tokenHandler: { token in
    // If printing tokens directly use `terminator: ""` as the tokens include whitespace and newlines.
    print(token, terminator: "")
  },
  stateChangeHandler: { state in
    switch state {
    case .notStarted:
      // ...
      break
    case .initializing:
      // ...
      break
    case .generatingOutput:
      // ...
      break 
    case .completed:
      // ...
      break
    case .failed(error: let error):
      // ...
      break
    }
  })

```

## Misc

- License: MIT
- Other matters: See the [llama.cpp repo](https://github.com/ggerganov/llama.cpp/).
