//
//  RACSignal+SignallingControl.h
//  CommandP
//
//  Created by Xaree on 5/18/15.
//  Copyright (c) 2015 commandp Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
@class RACSignal;

@interface NSTimer (RACSignalInterval)

/// Count up from 0 to the target value for every time interval.
/// @param interval Time interval to count once
/// @param count How many times to count
/// @note The signal will send an addtional initial value for the count.
+ (RACSignal *)racExt_countUpWithTimeInterval:(NSTimeInterval)interval count:(NSUInteger)count;

/// Count down from the target value to 0 for every time interval.
/// @param interval Time interval to count once
/// @param count How many times to count
/// @note The signal will send an addtional initial value for the count.
+ (RACSignal *)racExt_countDownWithTimeInterval:(NSTimeInterval)interval count:(NSUInteger)count;
@end