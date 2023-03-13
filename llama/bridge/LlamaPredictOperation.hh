//
//  LlamaPredictOperation.h
//  llama
//
//  Created by Alex Rozanski on 13/03/2023.
//

#import <Foundation/NSOperation.h>
#import "utils.h"

NS_ASSUME_NONNULL_BEGIN

@interface LlamaPredictOperation : NSOperation

@property (nonatomic, readonly) gpt_params params;

- (instancetype)initWithParams:(gpt_params)params;

@end

NS_ASSUME_NONNULL_END
