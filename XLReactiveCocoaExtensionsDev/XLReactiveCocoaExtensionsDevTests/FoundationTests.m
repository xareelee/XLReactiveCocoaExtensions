//
//  FoundationTests.m
//  XLReactiveCocoaExtensionsDev
//
//  Created by Xaree on 10/24/16.
//  Copyright © 2016 Xaree Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XLReactiveCocoaExtensions/XLReactiveCocoaExtensions.h>

@interface FoundationTests : XCTestCase

@end

@implementation FoundationTests

#pragma mark NSTimer

- (void)testNSTimerRACCountUp {
  XCTestExpectation *expectation = [self expectationWithDescription:@"test +[NSTimer racExt_countUpWithTimeInterval:fromZeroTo:]"];
  
  NSUInteger count = 5;
  RACSignal *counter$ = [NSTimer racExt_countUpWithTimeInterval:1 fromZeroTo:count];
  
  NSMutableArray *collection = [NSMutableArray arrayWithCapacity:6];
  NSArray *expectedResults = @[@0, @1, @2, @3, @4, @5];
  
  [counter$ subscribeNext:^(id  _Nullable x) {
    [collection addObject:x];
    
  } completed:^{
    XCTAssertEqual([collection count], count + 1);
    XCTAssert([collection isEqualToArray:expectedResults]);
    [expectation fulfill];
  }];
  
  [self waitForExpectationsWithTimeout:5.1 handler:^(NSError *error) {
    if(error) {
      XCTFail(@"Expectation Failed with error: %@", error);
    }
  }];
}

- (void)testNSTimerRACCountDown {
  XCTestExpectation *expectation = [self expectationWithDescription:@"test +[NSTimer racExt_countDownWithTimeInterval:toZeroFrom:]"];
  
  NSUInteger count = 5;
  RACSignal *counter$ = [NSTimer racExt_countDownWithTimeInterval:1 toZeroFrom:count];
  
  NSMutableArray *collection = [NSMutableArray arrayWithCapacity:6];
  NSArray *expectedResults = @[@5, @4, @3, @2, @1, @0];
  
  [counter$ subscribeNext:^(id  _Nullable x) {
    [collection addObject:x];
    
  } completed:^{
    XCTAssertEqual([collection count], count + 1);
    XCTAssert([collection isEqualToArray:expectedResults]);
    [expectation fulfill];
  }];
  
  [self waitForExpectationsWithTimeout:5.1 handler:^(NSError *error) {
    if(error) {
      XCTFail(@"Expectation Failed with error: %@", error);
    }
  }];
}


@end
