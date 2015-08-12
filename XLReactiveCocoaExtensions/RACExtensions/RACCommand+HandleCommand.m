//
//  RACCommand+HandleCommand.m
//  Pods
//
//  Created by Xaree on 8/1/15.
//
//

#import "RACCommand+HandleCommand.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation RACCommand (HandleCommand)

#pragma mark Command

+ (instancetype)racExt_commandWithEnabled:(RACSignal *)enabledSignal action:(void(^)(id input))action;
{
  return [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
    return [RACSignal defer:^RACSignal *{
      if (action) action(input);
      return [RACSignal return:input];
    }];
  }];

}

+ (instancetype)racExt_commandWithAction:(void(^)(id input))action;
{
  return [self racExt_commandWithEnabled:nil action:action];
}

+ (instancetype)racExt_commandWithEnabled:(RACSignal *)enabledSignal
{
  return [self racExt_commandWithEnabled:enabledSignal action:nil];
}

+ (instancetype)racExt_command
{
  return [self racExt_commandWithEnabled:nil action:nil];
}



#pragma mark Handle

- (RACDisposable *)racExt_handleCommandStart:(void (^)(RACSignal *signal))startBlock finished:(void (^)(void))finishedBlock;
{
  return [self racExt_handleCommandStart:startBlock next:nil error:nil finished:finishedBlock];
}

- (RACDisposable *)racExt_handleCommandStart:(void (^)(RACSignal *signal))startBlock next:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock finished:(void (^)(void))finishedBlock
{
  // Errors have been catched within RACCommand and sent to the `-errors` signal.
  RACDisposable *errorDisposable = [self.errors subscribeNext:^(NSError *error) {
    if (errorBlock) errorBlock(error);
  }];
  
  RACDisposable *startDisposable = [self.executionSignals subscribeNext:^(RACSignal *signal) {
    // Command started
    if (startBlock) startBlock(signal);
    
    // You can't subscribe the error here. You'll never receive the error.
    [signal subscribeNext:^(id x) {
      if (nextBlock) nextBlock(x);
    } completed:^{
      // Command Finished
      // NOTE: This block will also be invoked event if the source signal sends an error.
      if (finishedBlock) finishedBlock();
    }];
  }];
    
  RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposableWithDisposables:@[errorDisposable, startDisposable]];
  return disposable;
}

- (RACSignal *)completedSignal;
{
  return [self.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
    return [[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
      return event.eventType == RACEventTypeCompleted;
    }];
  }];
}

#pragma mark Channel to Another Command

- (RACDisposable *)channelToCommand:(RACCommand *)anotherCommand;
{
  return [[self.executionSignals flatten] subscribeNext:^(id x) {
    [anotherCommand execute:x];
  }];
}

@end
