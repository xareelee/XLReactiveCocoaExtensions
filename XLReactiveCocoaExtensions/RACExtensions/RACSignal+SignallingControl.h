//
//  RACSignal+SignallingControl.h
//  CommandP
//
//  Created by Xaree on 5/18/15.
//  Copyright (c) 2015 commandp Inc. All rights reserved.
//

#import "RACSignal.h"
@class RACDisposable;
@class RACCommand;


@interface RACSignal (SignallingControl)

#pragma mark Also When

/// 當 kickerSignal 或 signal 本身送下個 event 時，都會讓 signal 再次丟出值。
+ (RACSignal *)sendSignal:(RACSignal *)signal alsoWhen:(RACSignal *)kickerSignal;

/// 當 kickerSignal 送下個 event 時，都會讓本身再次丟出值。
- (RACSignal *)alsoWhen:(RACSignal *)kickerSignal;

#pragma mark Channel

/// 將 signal 的 next value 送到 command。
- (RACDisposable *)channelToCommand:(RACCommand *)anotherCommand;

@end
