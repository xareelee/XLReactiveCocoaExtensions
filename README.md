# XLReactiveCocoaExtensions

The missing part of ReactiveCocoa for development. This library provides some useful RACSignal(s).

**Since 3.x, this library current only supports ReactiveObjC 1.x.**


## Install via CocoaPods

```ruby
pod 'XLReactiveCocoaExtensions', '~> 3.0'
```

## API

### NSTimer

```objc
// Count up from 0: a signal which will count from 0 to 5 every second.
// events: 0-1-2-3-4-5|
RACSignal *counter$ = [NSTimer racExt_countUpWithTimeInterval:1 fromZeroTo:5];

// Count down to 0: a signal which will count from 5 to 0 every second.
// events: 5-4-3-2-1-0|
RACSignal *counter$ = [NSTimer racExt_countDownWithTimeInterval:1 toZeroFrom:5];
```
