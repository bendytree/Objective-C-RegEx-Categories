
# Objective-C RegEx Categories

## Overview

This project is a collection of objective-c categories for NSRegularExpression and NSString that make usage easier and more concise. For example:

```objc
//Using NSRegularExpression
NSString* string = @"I have 2 dogs.";
NSRegularExpression *regex = [NSRegularExpression regular ExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:&error];
NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
BOOL isMatch = match != nil;

// Using this library
BOOL isMatch = [@"I have 2 dogs." isMatch:RX(@"\\d+")];
```

## Getting Started

This library has no dependencies and works for iOS4+ and OSX v10.7+.

To install it, just copy these two files into your project:

 - RegExCategories.h
 - RegExCategories.m

You may want to add it to your Prefix.pch so that is is available across your code base.

```objc
#ifdef __OBJC__
    /* ...other references... */
    #import "RegExCategories.h"
#endif
```

You also need to have  [ARC](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_4_2.html) enabled on your XCode project. If you don't then add the `-fobjc-arc` flag on `Objective-C-Regex-Categories.m` under Targets > Build Phases > Compile Sources ([more info here](http://stackoverflow.com/a/19925947/193896)). 


## Examples


## Support

If you need help, [submit an issue](https://github.com/bendytree/Objective-C-RegEx-Categories/issues), [send a pull request](https://github.com/bendytree/Objective-C-RegEx-Categories/pulls), or tweet at me [@BendyTree](http://twitter.com/bendytree).


## Licensing

[MIT License](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/LICENSE.txt) - do whatever you want, just (1) provide attribution and (2) don't hold me liable.


## Travis-CI

This repository includes unit tests written in the [XCTest](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTestYourApp/UnitTestYourApp.html) framework. These test are automatically verified using [Travis-CI](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories). Here is the current status:

[![Build Status](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories.png)](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories)


