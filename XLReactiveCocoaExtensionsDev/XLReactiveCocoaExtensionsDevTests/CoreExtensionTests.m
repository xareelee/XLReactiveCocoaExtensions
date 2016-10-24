//
//  CoreExtensionTests.m
//  XLReactiveCocoaExtensionsDev
//
//  Created by Xaree on 10/24/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <XLReactiveCocoaExtensions/XLReactiveCocoaExtensions.h>
#import <Specta/Specta.h>
@import Nimble;

SpecBegin(RACSignalExtensionSpec)

describe(@"RACSignal", ^{
  
  describe(@"+ValueValidation", ^{
    
    describe(@"-racExt_hasValue", ^{
      
      it(@"should return @NO for any nil/false/0/empty value", ^{
        RACSubject *subject = [RACSubject subject];
        
        __block id result = nil;
        [[subject racExt_hasValue] subscribeNext:^(id  _Nullable x) {
          result = x;
        }];
        
        expect(result).to(beNil());
        
        
        // nils
        [subject sendNext:nil];
        expect(result).to(equal(@NO));
        
        [subject sendNext:[NSNull null]];
        expect(result).to(equal(@NO));
        
        
        // string
        [subject sendNext:@"a string"];
        expect(result).to(equal(@YES));
        
        [subject sendNext:@""];
        expect(result).to(equal(@NO));  // empty string
        
        
        // number
        [subject sendNext:@1];
        expect(result).to(equal(@YES));
        
        [subject sendNext:@0];
        expect(result).to(equal(@NO));  // 0
        
        [subject sendNext:@(-1)];
        expect(result).to(equal(@YES));
        
      });
      
    });
    
    describe(@"-racExt_isValidEmail", ^{
      
      it(@"should validate throught an email input sequence", ^{
        
        RACSubject *subject = [RACSubject subject];
        
        __block id result = nil;
        [[subject racExt_isValidEmail] subscribeNext:^(id  _Nullable x) {
          result = x;
        }];
        
        expect(result).to(beNil());
        
        
        // raise exception for non-string types
        expectAction(^{
          [subject sendNext:@10];
        }).to(raiseException());
        
        expectAction(^{
          [subject sendNext:@[]];
        }).to(raiseException());
        
        
        // send No for invalid emails
        [subject sendNext:nil];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@""];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@"hello"];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@"hello.world"];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@"hello.world@"];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@"hello.world@nihao"];
        expect(result).to(equal(@NO));
        
        [subject sendNext:@"@nihao.com"];
        expect(result).to(equal(@NO));
        
        
        // send YES for valid emails
        [subject sendNext:@"hello.world@nihao.com"];
        expect(result).to(equal(@YES));
        
        [subject sendNext:@"hello@nihao.com"];
        expect(result).to(equal(@YES));
        
      });
      
    });
    
    
  });
  
  
});

SpecEnd
