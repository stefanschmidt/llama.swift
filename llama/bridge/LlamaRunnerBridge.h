//
//  LlamaRunnerBridge.h
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

#import <Foundation/Foundation.h>

@class _LlamaRunnerBridgeConfig;

NS_ASSUME_NONNULL_BEGIN

@interface _LlamaRunnerBridge : NSObject

@property (nonnull, readonly, copy) NSString *modelPath;

- (instancetype)initWithModelPath:(nonnull NSString *)modelPath;

- (void)runWithPrompt:(nonnull NSString*)prompt
               config:(nonnull _LlamaRunnerBridgeConfig *)config
           completion:(void (^)())completion;
@end

NS_ASSUME_NONNULL_END
