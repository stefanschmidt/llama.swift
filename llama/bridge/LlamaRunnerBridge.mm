//
//  LlamaRunnerBridge.mm
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

#import "LlamaRunnerBridge.h"

@interface _LlamaRunnerBridge ()

@property (nonnull, copy) NSString *modelPath;

@end

@implementation _LlamaRunnerBridge

- (instancetype)initWithModelPath:(nonnull NSString *)modelPath
{
  if ((self = [super init])) {
    _modelPath = [modelPath copy];
  }
  return self;
}

- (void)runWithPrompt:(NSString *)prompt
{
  NSLog(@"%@", prompt);
}

@end
