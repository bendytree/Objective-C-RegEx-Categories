
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

Here's a quick overview. [See the docs for details.](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/docs.md)

    //Create an NSRegularExpression
    Rx* rx = RX(@"\\d");
    Rx* rx = [Rx rx:@"\\d"];
    Rx* rx = [Rx rx:@"\\d" ignoreCase:YES];

    //Test if a string matches
    BOOL isMatch = [@"2345" isMatch:RX(@"^\\d+$")];

    //Get first match
    NSString* age = [@"My dog is 3." firstMatch:RX(@"\\d+")];

    //Get matches as a string array
    NSString* words = [@"Hey pal" firstMatch:RX(@"\\w+")];
    // words => @[ @"Hey", @"pal" ]

    //Get first match with details
    RxMatch* match = [@"12.34, 56.78" firstMatchWithDetails:RX(@"\\d+([.]\\d+)")];
    // match.value => @"12.34"
    // match.range => NSRangeMake(0, 5);
    // match.original => @"12.34, 56.78";
    // match.groups => @[ RxMatchGroup, RxMatchGroup ];

    //Replace with a template string
    NSString* result = [@"My dog is 12." replace:RX(@"\\d+") with:@"old"];
    // result => @"My dog is old."

    //Replace with a block
    NSString* result = [RX(@"\\w+") replace:@"hi bud" withBlock:^(NSString* match){
      return [NSString stringWithFormat:@"%i", match.length];
    }];
    // result => @"2 3"

    //Replace with a block that has the match details
    NSString* result = [RX(@"\\w+") replace:@"hi bud" withDetailsBlock:^(RxMatch* match){
      return [NSString stringWithFormat:@"%i", match.value.length];
    }];
    // result => @"2 3"
    


## Support

If you need help, [submit an issue](https://github.com/bendytree/Objective-C-RegEx-Categories/issues), [send a pull request](https://github.com/bendytree/Objective-C-RegEx-Categories/pulls), or tweet at me [@BendyTree](http://twitter.com/bendytree).


## Licensing

[MIT License](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/LICENSE.txt) - do whatever you want, just (1) provide attribution and (2) don't hold me liable.


## Travis-CI

This repository includes unit tests written in the [XCTest](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTestYourApp/UnitTestYourApp.html) framework. These test are automatically verified using [Travis-CI](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories). Here is the current status:

[![Build Status](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories.png)](https://travis-ci.org/bendytree/Objective-C-RegEx-Categories)


