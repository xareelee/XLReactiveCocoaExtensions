//
//  FoundationTests.m
//  XLReactiveCocoaExtensionsDev
//
//  Created by Xaree on 10/24/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <XLReactiveCocoaExtensions/XLReactiveCocoaExtensions.h>
#import <Specta/Specta.h>
@import Nimble;

SpecBegin(FoundationSpec)

describe(@"NSTimer RAC Extension", ^{
  
  context(@"when count up", ^{
    it(@"should emit values every intervals", ^{
      waitUntilTimeout(5.1, ^(void (^done)(void)){
        NSUInteger count = 5;
        RACSignal *counter$ = [NSTimer racExt_countUpWithTimeInterval:1 fromZeroTo:count];
        
        NSMutableArray *collection = [NSMutableArray arrayWithCapacity:6];
        NSArray *expectedResults = @[@0, @1, @2, @3, @4, @5];
        
        [counter$ subscribeNext:^(id  _Nullable x) {
          [collection addObject:x];
          
        } completed:^{
          expect([collection count]).to(equal(count + 1));
          expect(collection).to(equal(expectedResults));
          done();
        }];
      });
    });
  });
  
  context(@"count down", ^{
    it(@"should emit values every intervals", ^{
      waitUntilTimeout(5.1, ^(void (^done)(void)){
        NSUInteger count = 5;
        RACSignal *counter$ = [NSTimer racExt_countDownWithTimeInterval:1 toZeroFrom:count];
        
        NSMutableArray *collection = [NSMutableArray arrayWithCapacity:6];
        NSArray *expectedResults = @[@5, @4, @3, @2, @1, @0];
        
        [counter$ subscribeNext:^(id  _Nullable x) {
          [collection addObject:x];
          
        } completed:^{
          expect([collection count]).to(equal(count + 1));
          expect(collection).to(equal(expectedResults));
          done();
        }];
      });
    });
  });
  
  
});

SpecEnd

