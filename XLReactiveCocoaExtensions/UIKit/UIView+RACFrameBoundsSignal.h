//
//  UIView+RACFrameBoundsSignal.h
//  Pods
//
//  Created by Xaree on 8/4/15.
//
//

#import <UIKit/UIKit.h>
@class RACSignal;

@interface UIView (RACFrameBoundsSignal)
- (RACSignal *)racExt_frameSignal;
@end
