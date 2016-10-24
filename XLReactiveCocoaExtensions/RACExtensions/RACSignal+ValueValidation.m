//
//  RACSignal+HasValue.m
//  Pods
//
//  Created by Xaree on 8/1/15.
//
//

#import "RACSignal+ValueValidation.h"
#import <ReactiveObjC/ReactiveObjC.h>


@implementation RACSignal (ValueValidation)

- (RACSignal *)racExt_hasValue;
{
  return
  [[self
    map:^id(id value) {
      if (!value)
        return @NO;
      if ([value respondsToSelector:@selector(length)])
        return @([value length] > 0);
      if ([value respondsToSelector:@selector(integerValue)])
        return @([value integerValue] != 0);
      if ([value respondsToSelector:@selector(hasValue)])
        return @([value hasValue]);
      if ([value isEqual:[NSNull null]]) {
        return @NO;
      }
      
      NSCAssert(NO, @"This value type (%@) cound not be evaluated by -[RACSignal hasValue]. Try to implement -hasValue on this class.", NSStringFromClass([value class]));
      return @NO;
    }]
    setNameWithFormat:@"%@ -%@", self.name, NSStringFromSelector(_cmd)];
}

- (RACSignal *)racExt_isValidEmail;
{
  // see http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
  return
  [[self
    map:^id(NSString *email) {
      BOOL isString = [email isKindOfClass:[NSString class]];
      NSCAssert(isString, @"The email value (%@) should be kind NSString.", NSStringFromClass([email class]));
      if (!isString) {
        return @NO;
      }
      // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
      BOOL stricterFilter = NO;
      NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
      NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
      NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
      NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
      return @([emailTest evaluateWithObject:email]);
    }]
    setNameWithFormat:@"%@ -%@", self.name, NSStringFromSelector(_cmd)];;
}
@end
