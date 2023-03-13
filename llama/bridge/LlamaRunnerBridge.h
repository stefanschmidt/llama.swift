//
//  LlamaRunnerBridge.h
//  llama
//
//  Created by Alex Rozanski on 12/03/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _LlamaRunnerBridge : NSObject

- (instancetype)initWithModelPath:(nonnull NSString *)modelPath;

- (void)runWithPrompt:(nonnull NSString*)prompt;

@end

NS_ASSUME_NONNULL_END
