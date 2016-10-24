//
//  XLReactiveCocoaExtension.h
//  CMDPUserLogin
//
//  Created by Xaree on 8/2/15.
//  Copyright (c) 2015 Xaree Lee. All rights reserved.
//

#ifndef CMDPUserLogin_XLReactiveCocoaExtension_h
#define CMDPUserLogin_XLReactiveCocoaExtension_h

#import <ReactiveObjC/ReactiveObjC.h>

// RACExtensions
#import <XLReactiveCocoaExtensions/RACSignal+ValueValidation.h>
#import <XLReactiveCocoaExtensions/RACCommand+HandleCommand.h>
#import <XLReactiveCocoaExtensions/RACSignal+SignallingControl.h>

// Foundation
#import <XLReactiveCocoaExtensions/NSTimer+RACSignalInterval.h>

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
  // CocoaTouch
  #import <XLReactiveCocoaExtensions/UIView+RACFrameBoundsSignal.h>
  #import <XLReactiveCocoaExtensions/UITextField+RACKeyboardSupport.h>
  #import <XLReactiveCocoaExtensions/UIButton+RACTitleSupport.h>

#elif TARGET_OS_MAC
  // Cocoa
#endif

#endif
