//
//  LlamaRunnerBridge.mm
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

#import "LlamaRunnerBridge.h"
#import "LlamaEvent.h"
#import "LlamaRunnerBridgeConfig.h"
#import "LlamaPredictOperation.hh"

#import "utils.h"

@implementation _LlamaRunnerBridge {
  NSOperationQueue *_operationQueue;
}

- (instancetype)initWithModelPath:(nonnull NSString *)modelPath
{
  if ((self = [super init])) {
    _modelPath = [modelPath copy];
    _operationQueue = [[NSOperationQueue alloc] init];
    _operationQueue.qualityOfService = NSQualityOfServiceUserInitiated;
  }
  return self;
}

- (void)runWithPrompt:(nonnull NSString*)prompt
               config:(nonnull _LlamaRunnerBridgeConfig *)config
         eventHandler:(nonnull _LlamaRunnerBridgeEventHandler)eventHandler
           completion:(void (^)())completion
{
  gpt_params params;
  params.model = [_modelPath cStringUsingEncoding:NSUTF8StringEncoding];
  params.prompt = [prompt cStringUsingEncoding:NSUTF8StringEncoding];

  params.n_threads = (int)config.numberOfThreads;
  params.n_predict = (int)config.numberOfTokens;

  if (config.reversePrompt != nil) {
    params.antiprompt = [config.reversePrompt cStringUsingEncoding:NSUTF8StringEncoding];
  }

  LlamaPredictOperation *operation = [[LlamaPredictOperation alloc] initWithParams:params
                                                                      eventHandler:eventHandler
                                                                 eventHandlerQueue:dispatch_get_main_queue()];
  [operation setCompletionBlock:completion];
  [_operationQueue addOperation:operation];
}

@end
