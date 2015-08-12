//
//  UIButton+RACTitleSupport.h
//  Pods
//
//  Created by Xaree on 8/2/15.
//
//

#import <UIKit/UIKit.h>
@class RACSignal;


@interface UIButton (RACTitleSupport)

/// Make the button support `RAC()` syntax.
///
/// @code
/// RAC(self, button.racExt_Title) = titleSignal;
/// @endcode
@property (strong, nonatomic) NSString *racExt_Title;

// Set the title of this button by titleSignal with the state.
- (RACSignal *)racExt_setTitle:(RACSignal *)titleSignal state:(UIControlState)state;

// Set the title of this button by titleSignal with state UIControlStateNormal.
- (RACSignal *)racExt_setTitle:(RACSignal *)titleSignal;
@end
