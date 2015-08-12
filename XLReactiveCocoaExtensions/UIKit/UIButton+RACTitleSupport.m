//
//  UIButton+RACTitleSupport.m
//  Pods
//
//  Created by Xaree on 8/2/15.
//
//

#import "UIButton+RACTitleSupport.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation UIButton (RACTitleSupport)

#pragma mark Dynamic Property for RAC
@dynamic racExt_Title;

- (void)setRacExt_Title:(NSString *)racExt_Title
{
  [self setTitle:racExt_Title forState:UIControlStateNormal];
}
- (NSString *)racExt_Title
{
  return [self titleForState:UIControlStateNormal];
}

#pragma mark Convenient RAC lift 

- (RACSignal *)racExt_setTitle:(RACSignal *)titleSignal state:(UIControlState)state;
{
  NSAssert(titleSignal, @"Title signal must not be nil.");
  if (!titleSignal) {
    return [RACSignal return:nil];
  }
  RACSignal *buttonStateSignal = [RACSignal return:@(state)];
  return [self rac_liftSelector:@selector(setTitle:forState:) withSignalsFromArray:@[titleSignal, buttonStateSignal]];
}

- (RACSignal *)racExt_setTitle:(RACSignal *)titleSignal;
{
  return [self racExt_setTitle:titleSignal state:UIControlStateNormal];
}
@end
