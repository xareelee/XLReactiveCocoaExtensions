//
//  UITextField+RACKeyboardSupport.h
//  Pods
//
//  Created by Xaree on 7/29/15.
//
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface UITextField (RACEXTKeyboardSupport)

/// A signal which will send a next value when tapping the return key in the
/// keyboard for this text field.
- (RACSignal *)racExt_keyboardReturnSignal;
@end


@interface NSArray (RACEXTKeyboardSupport)

/// Text fields in this array will be chained up by replacing the first responder.
/// When tapping the return key in the keyboard, it will automatically call the
/// next field in this array to become the first responder.
///
/// Excepting the last text field, the type of the return key of the text field
/// will be changed to type `Next`.
///
/// @param doneBlock Tapping the return key of the Last text field in this array
/// will invoke the `doneBlock`. If the doneBlock is nil, tapping the return key
/// will not cause the keybaord to be dismissed automatically.
- (RACDisposable *)racExt_chainUpTextFieldsAndSubscribeNextForLastField:(void (^)(id x))doneBlock;

- (RACDisposable *)racExt_textFieldNextChainUp:(void (^)(id x))doneBlock __attribute__((deprecated("Use -racExt_chainUpTextFieldAndSubscribeCompletion:")));
@end