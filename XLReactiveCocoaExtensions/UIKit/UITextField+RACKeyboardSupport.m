//
//  UITextField+RACKeyboardSupport.m
//  Pods
//
//  Created by Xaree on 7/29/15.
//
//

#import "UITextField+RACKeyboardSupport.h"
#import <ReactiveCocoa/NSObject+RACDescription.h>


@implementation UITextField (RACEXTKeyboardSupport)
- (RACSignal *)racExt_keyboardReturnSignal
{
  // see https://gist.github.com/lukeredpath/9051769
  @weakify(self);
  return
  [[[[[RACSignal
    defer:^{
      @strongify(self);
      return [RACSignal return:self];
    }]
    concat:[self rac_signalForControlEvents:UIControlEventEditingDidEndOnExit]]
    skip:1]
    takeUntil:self.rac_willDeallocSignal]
    setNameWithFormat:@"%@ -rac_keyboardReturnSignal", [self rac_description]];
}

@end


@implementation NSArray (RACEXTKeyboardSupport)

- (RACDisposable *)racExt_chainUpTextFieldsAndSubscribeNextForLastField:(void (^)(id x))doneBlock;
{
  RACCompoundDisposable *compoundDisposable = [RACCompoundDisposable compoundDisposable];
  __block UITextField *lastChainedTextField = nil;
  [self enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger idx, BOOL *stop) {
    BOOL isTextField = [textField isKindOfClass:[UITextField class]];
    NSAssert(isTextField, @"The object (idx: %lu) in the array for -%@ is not UITextField. Object: %@ <%p>", idx, NSStringFromSelector(_cmd), NSStringFromClass([textField class]), textField);
    if (!isTextField) {
      return; // skip this object in runtime.
    }
    // Build the chain
    lastChainedTextField.returnKeyType = UIReturnKeyNext;
    RACDisposable *disposable = [lastChainedTextField.racExt_keyboardReturnSignal subscribeNext:^(id x) {
      [textField becomeFirstResponder];
    }];
    [compoundDisposable addDisposable:disposable];
    
    lastChainedTextField = textField;
  }];
  
  // Add the done block to the last text field in the chain.
  if (doneBlock) {
    RACDisposable *disposable = [lastChainedTextField.racExt_keyboardReturnSignal subscribeNext:doneBlock];
    [compoundDisposable addDisposable:disposable];
  }
  return compoundDisposable;
}

// Deprecated
- (RACDisposable *)racExt_textFieldNextChainUp:(void (^)(id x))doneBlock
{
  return [self racExt_chainUpTextFieldAndSubscribeCompletion:doneBlock];
}

@end