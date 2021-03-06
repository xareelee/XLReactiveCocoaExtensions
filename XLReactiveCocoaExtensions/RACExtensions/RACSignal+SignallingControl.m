//
//  RACSignal+SignallingControl.m
//  CommandP
//
//  Created by Xaree on 5/18/15.
//  Copyright (c) 2015 commandp Inc. All rights reserved.
//

#import "RACSignal+SignallingControl.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation RACSignal (SignallingControl)

#pragma mark Also When

+ (RACSignal *)sendSignal:(RACSignal *)signal alsoWhen:(RACSignal *)kickerSignal;
{
  return [signal alsoWhen:kickerSignal];
}

- (RACSignal *)alsoWhen:(RACSignal *)kickerSignal;
{
  // Start with a nil value
  RACSignal *autoStartedKickerSignal = [kickerSignal startWith:nil];
  return [[self combineLatestWith:autoStartedKickerSignal] reduceEach:^id (id value, id kicker){
    return value;
  }];
}

#pragma mark Channel

- (RACDisposable *)channelToCommand:(RACCommand *)anotherCommand;
{
  return [self subscribeNext:^(id x) {
    [anotherCommand execute:x];
  }];
}

@end
