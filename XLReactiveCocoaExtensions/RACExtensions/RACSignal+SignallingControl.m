//
//  RACSignal+SignallingControl.m
//  CommandP
//
//  Created by Xaree on 5/18/15.
//  Copyright (c) 2015 commandp Inc. All rights reserved.
//

#import "RACSignal+SignallingControl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RACSignal (SignallingControl)

#pragma mark Also When

+ (RACSignal *)sendSignal:(RACSignal *)signal alsoWhen:(RACSignal *)kickerSignal;
{
  return [signal alsoWhen:kickerSignal];
}

- (RACSignal *)alsoWhen:(RACSignal *)kickerSignal;
{
  return [self sample:[RACSignal merge:@[self, kickerSignal]]];
}

#pragma mark Channel

- (RACDisposable *)channelToCommand:(RACCommand *)anotherCommand;
{
  return [self subscribeNext:^(id x) {
    [anotherCommand execute:x];
  }];
}

@end
