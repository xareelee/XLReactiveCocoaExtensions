# XLReactiveCocoaExtensions

The missing part of ReactiveCocoa for development. This library provides some useful RACSignal(s).

**Since 3.x, this library current only supports ReactiveObjC 1.x.**


## Install via CocoaPods

```ruby
pod 'XLReactiveCocoaExtensions', '~> 3.0'
```

## API

### RAC Extensions

`-[RACSignal racExt_hasValue]`: evalute value and return a boolean value

```objc
// return NO
[[RACSignal return:nil] racExt_hasValue];
[[RACSignal return:[NSNull null]] racExt_hasValue];
[[RACSignal return:@""] racExt_hasValue]; // empty string is @NO
[[RACSignal return:@0] racExt_hasValue];  // 0 is @NO
// return YES
[[RACSignal return:@"hello"] racExt_hasValue];
[[RACSignal return:@100] racExt_hasValue];
// evaluate by calling -hasValue on objects (you could extend it by Category)
[[RACSignal return:obj] racExt_hasValue]; // evaluate -[obj hasValue]
```

`-[RACSignal racExt_isValidEmail]`: evaluate whether the value is valid email format. Useful with `UITextField`.

```
[[RACSignal return:nil] racExt_isValidEmail]; // NO
[[RACSignal return:@""] racExt_isValidEmail]; // NO
[[RACSignal return:@"hello"] racExt_isValidEmail]; // NO
[[RACSignal return:@"hello@world"] racExt_isValidEmail]; // NO
[[RACSignal return:@"hello@world.com"] racExt_isValidEmail]; // YES
```



### NSTimer

```objc
// Count up from 0: a signal which will count from 0 to 5 every second.
// events: 0-1-2-3-4-5|
RACSignal *counter$ = [NSTimer racExt_countUpWithTimeInterval:1 fromZeroTo:5];

// Count down to 0: a signal which will count from 5 to 0 every second.
// events: 5-4-3-2-1-0|
RACSignal *counter$ = [NSTimer racExt_countDownWithTimeInterval:1 toZeroFrom:5];
```
