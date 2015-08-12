//
//  RACCommand+HandleCommand.h
//  Pods
//
//  Created by Xaree on 8/1/15.
//
//

#import "RACCommand.h"

@class RACSignal;
@class RACDisposable;
@class NSError;

@interface RACCommand (HandleCommand)

/// Convenient method to create a command via action block with an enable signal.
/// Use it just like target-action. The command's execution signals will send
/// a next value and a completed event once it finish the action.
+ (instancetype)racExt_commandWithEnabled:(RACSignal *)enabledSignal action:(void(^)(id input))action;

/// Convenient method to create a command via action block without anenable signal.
/// @seealso +commandWithEnabled:action:
+ (instancetype)racExt_commandWithAction:(void(^)(id input))action;

/// Convenient method to create an empty command with enabledSignal. This command
/// will simply pass the next value and completed event to `-executingSignals`,
/// and then finish its job.
/// @seealso +racExt_command:
+ (instancetype)racExt_commandWithEnabled:(RACSignal *)enabledSignal;

/// When executing the returning command, it will just simply pass the input
/// value to the `-executingSignals` and then send the completed signal.
/// @seealso +commandWithEnabled:action:
+ (instancetype)racExt_command;


/// A composite subscription for a command to track start, next, error, and
/// finish events.
///
/// Note: the finished block is NOT equivalent to a completed block as a
/// subscription. Sending errors will also trigger the finished block. The
/// execution sequence between errorBlock and finishedBlock is undetermined.
///
/// @param startBlock Be invoked when this command is just executed.
/// @param nextBlock Be invoked when receiving any next values.
/// @param errorBlock Be invoked when receiving any error.
/// @param finishedBlock Be invoked when this command is finished.
///
/// @return A compound disposable that you chould use it to dispose the
/// command handler (subscriptions).
- (RACDisposable *)racExt_handleCommandStart:(void (^)(RACSignal *signal))startBlock next:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock finished:(void (^)(void))finishedBlock;

/// Convenient handler for start and finish.
- (RACDisposable *)racExt_handleCommandStart:(void (^)(RACSignal *signal))startBlock finished:(void (^)(void))finishedBlock;


/// Send the next value to another command.
/// @param anotherCommand The command you want to trigger when this command
/// has sent a value.
- (RACDisposable *)channelToCommand:(RACCommand *)anotherCommand;


#pragma mark Command Signal

- (RACSignal *)completedSignal;
@end
