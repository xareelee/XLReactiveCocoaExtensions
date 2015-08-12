//
//  RACSignal+HasValue.h
//  Pods
//
//  Created by Xaree on 8/1/15.
//
//

#import "RACSignal.h"


// You cound implement this method to support -racExt_hasValue for undetermined class.
@interface NSObject(RACEXTValueValidation)
- (BOOL)hasValue;
@end


@interface RACSignal (RACEXTValueValidation)
/// This signal will send `@YES` when the length is greater than 0 (NSString or
/// NSArray), the value is not 0 (NSNumber), or its `-hasValue` returns `YES`.
- (RACSignal *)racExt_hasValue;

/// This signal will send `@YES` if its string value is a valid email.
- (RACSignal *)racExt_isValidEmail;
@end

