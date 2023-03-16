//
//  LlamaError.h
//  llama
//
//  Created by Alex Rozanski on 14/03/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const LlamaErrorDomain;

typedef NS_ENUM(NSInteger, LlamaErrorCode) {
  LlamaErrorCodeUnknown = -1,

  LlamaErrorCodeFailedToLoadModel = -1000,
  LlamaErrorCodePredictionFailed = -1001,
};

NS_ASSUME_NONNULL_END
