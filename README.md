# llama.swift

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A fork of [@ggerganov](https://github.com/ggerganov)'s [llama.cpp](https://github.com/ggerganov/llama.cpp) to use [Facebook's LLaMA](https://github.com/facebookresearch/llama) models in Swift.

See the [main repository](https://github.com/ggerganov/llama.cpp/) for info about the original goals of the project and implementation.

## LLaMA Setup

Clone the repo:

```bash
git clone https://github.com/alexrozanski/llama.swift.git
cd llama.swift
```

Grab the LLaMA model weights and place them in `./models`. `ls` should print something like:

```bash
ls ./models
65B 30B 13B 7B tokenizer_checklist.chk tokenizer.model
```

To convert the LLaMA-7B model and quantize:

```bash
# install Python dependencies
python3 -m pip install torch numpy sentencepiece

# the command-line tools are in `./tools` instead of the repo root like in llama.cpp
cd tools

# convert the 7B model to ggml FP16 format
python3 convert-pth-to-ggml.py ../models/7B/ 1

# quantize the model to 4-bits
make
./quantize.sh 7B
```

When running the larger models, make sure you have enough disk space to store all of the intermediate files.

## Installation

### Swift Package Manager

Add `llama.swift` to your project using Xcode (File > Add Packages...) or by adding it to your project's `Package.swift` file:

```swift
dependencies: [
  .package(url: "https://github.com/alexrozanski/llama.swift.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

### Swift library

For now `llama` has a simple API:

```swift
import llama

let url = ... // URL to the ggml-model-q4_0.bin model file
let runner = LlamaRunner(modelURL: url)

runner.run(
  with: "Building a website can be done in 10 simple steps:",
  config: LlamaRunner.Config(numThreads: 8, numTokens: 512) // Can also specify `reversePrompt`
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

**NOTE:** Because of the way the Swift package is structured (and some gaps in my knowledge around exported symbols from modules), including `llama.swift` also leaks the name of the internal module `llamaObjCxx` to Xcode, as well as some internal classes prefixed with `_Llama`, but you can ignore these for now.


### `llamaTest` app

The repo contains a barebones command-line tool, `llamaTest`, which uses the `llama` Framework to run a simple input loop to run inference on a given input prompt.

- Ensure to set `MODEL_PATH` in `LlamaTest.xcconfig` to point to your `path/to/ggml-model-q4_0.bin` (without quotes or spaces after `MODEL_PATH=`), for example:

```
MODEL_PATH=/path/to/ggml-model-q4_0.bin
```

- Build for Release if you want this to be snappy, since `llama` will run slowly in Debug builds.

## Misc

- License: MIT
- Other matters: See the [llama.cpp repo](https://github.com/ggerganov/llama.cpp/).
