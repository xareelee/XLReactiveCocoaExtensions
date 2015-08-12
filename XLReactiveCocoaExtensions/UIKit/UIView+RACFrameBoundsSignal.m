//
//  UIView+RACFrameBoundsSignal.m
//  Pods
//
//  Created by Xaree on 8/4/15.
//
//

#import "UIView+RACFrameBoundsSignal.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@implementation UIView (RACFrameBoundsSignal)

- (RACSignal *)racExt_frameSignal
{
  RACSignal *frameChangeSignal = [RACSignal merge:@[RACObserve(self, frame), RACObserve(self, bounds), RACObserve(self, center)]];
  
  return [[[frameChangeSignal mapReplace:self] map:^id(UIView *view) {
    return [NSValue valueWithCGRect:view.frame];
  }] distinctUntilChanged];
}

@end
