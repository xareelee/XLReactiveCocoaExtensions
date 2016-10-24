//
//  RACSignal+SignallingControl.m
//  CommandP
//
//  Created by Xaree on 5/18/15.
//  Copyright (c) 2015 commandp Inc. All rights reserved.
//

#import "NSTimer+RACSignalInterval.h"
#import <ReactiveObjC/ReactiveObjC.h>


@implementation NSTimer (RACSignalInterval)

+ (RACSignal *)racExt_countUpWithTimeInterval:(NSTimeInterval)interval fromZeroTo:(NSUInteger)count;
{
  NSNumber *startValue = @(0);
  return
  [[[[RACSignal interval:interval onScheduler:RACScheduler.mainThreadScheduler] take:count] scanWithStart:startValue reduce:^id(id running, id next) {
    return @([running integerValue] + 1);
  }] startWith:startValue];

}

+ (RACSignal *)racExt_countDownWithTimeInterval:(NSTimeInterval)interval toZeroFrom:(NSUInteger)count;
{
  NSNumber *startValue = @(count);
  return
  [[[[RACSignal interval:interval onScheduler:RACScheduler.mainThreadScheduler] take:count] scanWithStart:startValue reduce:^id(id running, id next) {
    return @([running integerValue] - 1);
  }] startWith:startValue];
  
}

@end




@implementation NSTimer (RACSignalInterval_Deprecated)

+ (RACSignal *)racExt_countUpWithTimeInterval:(NSTimeInterval)interval count:(NSUInteger)count {
  [self racExt_countUpWithTimeInterval:interval fromZeroTo:count];
}

+ (RACSignal *)racExt_countDownWithTimeInterval:(NSTimeInterval)interval count:(NSUInteger)count {
  [self racExt_countDownWithTimeInterval:interval toZeroFrom:count];
}

@end
