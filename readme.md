# Objective-C RegEx Categories

<img title="Make Regular Expressions Easier in Objective-C" alt="Make Regular Expressions Easier in Objective-C" src="https://raw.github.com/bendytree/Objective-C-RegEx-Categories/master/TestProject/Objective-C-Regex-Categories/Images/icon.png" align="right" width="250" height="250" />

 - [Introduction](#introduction)
 - [Getting Started](#gettingstarted)
   - [Cocoa Pods](#gettingstarted-cocoapods)
   - [Download](#gettingstarted-download)
   - [Swift Support](#gettingstarted-swift)
 - [Quick Examples](#examples)
 - [Documentation](#documentation)
   - [Macros](#macros)
   - [Creation](#creation)
   - [Test If Match](#ismatch)
   - [Index Of Match](#indexof)
   - [Split](#split)
   - [First Match](#firstmatch)
   - [Matches](#matches)
   - [Replace](#replace)
   - [RxMatch Objects](#rxmatch)
 - [Support](#support)
 - [Licensing](#licensing)
 - [Testing](#testing)
 - [Alternatives](#alternatives)
 - [Who Uses It](#whousesit)


<a name="introduction"/>
## Introduction

This project simplifies regular expressions in Objective-C and Swift.

As of iOS 4 (and OSX 10.7), [`NSRegularExpression`](https://developer.apple.com/library/Mac/DOCUMENTATION/Foundation/Reference/NSRegularExpression_Class/Reference/Reference.html) is built-in to [Foundation.framework](https://developer.apple.com/library/Mac/DOCUMENTATION/Cocoa/Reference/Foundation/ObjC_classic/_index.html#//apple_ref/doc/uid/20001091). The syntax is somewhat cumbersome and it leaves much of the work to you, so this library creates categories and macros to simplify usage of `NSRegularExpression`. 

Here is an example where four lines of code become one:

```objc
// Without this library
NSString* string = @"I have 2 dogs.";
NSRegularExpression *regex = [NSRegularExpression regular ExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:&error];
NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
BOOL isMatch = match != nil;

// With this library
BOOL isMatch = [@"I have 2 dogs." isMatch:RX(@"\\d+")];
```

**TIP:** Refer to the header ([RegExCategories.h](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/RegExCategories.h)) for more details and examples.

<a name="gettingstarted"/>
## Getting Started

This library has no dependencies and works for iOS 4+ and OSX 10.7+. 

<a name="gettingstarted-cocoapods"/>
### Installing Via CocoaPods

If you use [Cocoa Pods](http://cocoapods.org/), then just add the following to your `Podfile`. Then run `pod install` from the command line.

    pod 'RegExCategories', '~> 1.0'

<a name="gettingstarted-download"/>
### Installing Via Download

You can also just copy these two files into your project:

 - [RegExCategories.h](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/RegExCategories.h)
 - [RegExCategories.m](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/RegExCategories.m)

You may want to add it to your [AppName]-Prefix.pch so that is is available across your code base.

```objc
#ifdef __OBJC__
    /* ...other references... */
    #import "RegExCategories.h"
#endif
```

You also need to have  [ARC](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/WhatsNewXcode/Articles/xcode_4_2.html) enabled on your XCode project. If you don't then add the `-fobjc-arc` flag on `RegExCategories.m` under Targets > Build Phases > Compile Sources ([more info](http://stackoverflow.com/a/19925947/193896)). 

<a name="gettingstarted-swift"/>
### Swift Support

You can use these extensions in [Swift](https://developer.apple.com/swift/). There are [additional steps](http://michal.codes/integrating-cocoapods-with-a-swift-project/) you must take to use Objective-C code from Swift. Once you've installed via Cocoa Pods or via download, do the following:

 1. Add a Bridging Header
    
    This file will allow you to use objective-c code from your `.swift` code. Create an objective-c header file named [YourProjectName]-Bridging-Header.h

 2. Configure The Bridging Header
    
    In the `Build Settings` of your main project, scroll down to the "Swift Compiler - Code Generation" section. In "Objective-C Bridging Header" add your file. Typically your value will be `[YourProjectName]/[YourProjectName]-Bridging-Header.h`.  Build your project - if you have errors then you've set the wrong path.

 3. Import RegExCategories
 
    In your bridging header, import the header for this library. For example, if you use Cocoa Pods it may look like this:

        #import <RegExCategories/RegExCategories.h>
    
    If you just copied the files in to your project, it may look like this:
    
        #import "RegExCategories.h"


<a name="examples"/>
## Quick Examples

Here are some short examples of how you might use the code. The [documentation](#documentation) section below goes into full detail.


```objc
//Create an NSRegularExpression
Rx* rx = RX(@"\\d");
Rx* rx = [Rx rx:@"\\d"];
Rx* rx = [Rx rx:@"\\d" ignoreCase:YES];

//Test if a string matches
BOOL isMatch = [@"2345" isMatch:RX(@"^\\d+$")];

//Get first match
NSString* age = [@"My dog is 3." firstMatch:RX(@"\\d+")];

//Get matches as a string array
NSArray* words = [@"Hey pal" matches:RX(@"\\w+")];
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
```

You can also use the extensions in Swift, though macros are not available. Most examples are in Objective-C but here are some Swift examples:

```swift
//Create an NSRegularExpression
var rx = NSRegularExpression(pattern:"\\d");
var rx = NSRegularExpression.rx("\\d", ignoreCase:true);
var rx = NSRegularExpression.rx("\\d", options: .CaseInsensitive);

//Test if Matches a String
var isMatch = rx.isMatch("3 dogs");
```

<a name="documentation"/>
## Documentation

<a name="macros"/>
## Macros

First off, we create an alias for NSRegularExpression named `Rx`. So instead of writing `NSRegularExpression` you can now use `Rx`. (this can be disabled - read on)

```objc
//this
NSRegularExpression* rx = [[NSRegularExpression alloc] initWithPattern:@"\\d"];

//can be written as
Rx* rx = [[Rx alloc] initWithPattern:@"\\d"];
```

We've also created a macro `RX()` for quick regex creation. Just pass a string and an `NSRegularExpression` object is created:

```objc
//this
NSRegularExpression* rx = [[NSRegularExpression alloc] initWithPattern:@"\\d"];

//can be written as
Rx* rx = RX(@"\\d");
```

These macros can be disabled by defining `DisableRegExCategoriesMacros` before you include the script. For example:

```objc
#define DisableRegExCategoriesMacros
#include "RegExCategories.h"
```

<a name="creation"/>
## Creation

Here are a few convenient ways to create an `NSRegularExpression`.

######Class Method - rx

    Rx* rx = [Rx rx:@"\\d+"];

######Class Method - ignore case

    Rx* rx = [Rx rx:@"\\d+" ignoreCase:YES];

######Class Method - with options

    Rx* rx = [Rx rx:@"\\d+" options:NSRegularExpressionCaseInsensitive];

######Init With Pattern

    Rx* rx = [[Rx alloc] initWithPattern:@"\d+"];

######String Extension

	Rx* rx = [@"\\d+" toRx];

######String Extension - ignore case

	Rx* rx = [@"\\d+" toRxIgnoreCase:YES];

######String Extension - with options

	Rx* rx = [@"\\d+" toRxWithOptions:NSRegularExpressionCaseInsensitive];


<a name="ismatch"/>
##Test If Match

Tests whether a regular expression matches a string.

######From NSRegularExpression

    BOOL isMatch = [RX(@"\\d+") isMatch:@"Dog #1"];
    // => true

######From NSString

    BOOL isMatch = [@"Dog #1" isMatch:RX(@"\\d+")];
    // => true


<a name="indexof"/>
##Index Of Match

Get the character index of the first match. If no match is found, then `-1`.

######From NSRegularExpression

    int index = [RX(@"\\d+") indexOf:@"Buy 1 dog or buy 2?"];
    // => 4

    int index = [RX(@"\\d+") indexOf:@"Buy a dog?"];
    // => -1

######From NSString

    int index = [@"Buy 1 dog or buy 2?" indexOf:RX(@"\\d+")];
    // => 4

    int index = [@"Buy a dog?" indexOf:RX(@"\\d+")];
    // => -1


<a name="split"/>
##Split A String

Split an NSString using a regex as the delimiter. The result is an NSArray of NSString objects.

######From NSRegularExpression

    NSArray* pieces = [RX(@"[ ,]") split:@"A dog,cat"];
    // => @[@"A", @"dog", @"cat"]


######From NSString

    NSArray* pieces = [@"A dog,cat" split:RX(@"[ ,]")];
    // => @[@"A", @"dog", @"cat"]

Empty results are not removed. For example:

    NSArray* pieces = [@",a,,b," split:RX(@"[,]")];
    // => @[@"", @"a", @"", @"b", @""]


<a name="firstmatch"/>
##First Match

Get the first match as an `NSString`. If no match is found, nil is returned.

###### First Match from NSString

    NSString* match = [@"55 or 99 spiders" firstMatch:RX(@"\\d+")];
    // => @"55"

    NSString* match = [@"A lot of spiders" firstMatch:RX(@"\\d+")];
    // => nil

###### First Match from NSRegularExpression

    NSString* match = [RX(@"\\d+") firstMatch:@"55 or 99 spiders"];
    // => @"55"

###### First Match With Details (from NSString or NSRegularExpression)

If you want more details about the match (such as the range or captured groups), then use match with details. It returns an [RxMatch](#rxmatch) object if a match is found, otherwise nil.

    RxMatch* match = [@"55 or 99 spiders" firstMatchWithDetails:RX(@"\\d+")];
    // => { value: @"55", range:NSRangeMake(0, 2), groups:[RxMatchGroup, ...] }

    RxMatch* match = [@"A lot of spiders" firstMatchWithDetails:RX(@"\\d+")];
    // => nil

    RxMatch* match = [RX(@"\\d+") firstMatchWithDetails:@"55 or 99 spiders"];
    // => { value: @"55", range:NSRangeMake(0, 2), groups:[RxMatchGroup, ...] }



<a name="matches"/>
##Matches


###### Matches (from NSString or NSRegularExpression)

Matches returns all matches as an `NSArray`, each as an `NSString`. If no matches are found, the `NSArray` is empty.

    NSArray* matches = [@"55 or 99 spiders" matches:RX(@"\\d+")];
    // => @[ @"55", @"99" ]

    NSArray* matches = [RX(@"\\d+") matches:@"55 or 99 spiders"];
    // => @[ @"55", @"99" ]


###### Matches With Details (from NSString or NSRegularExpression)

Matches with details returns all matches as an `NSArray`, each object is an [RxMatch](#rxmatch) object.

    NSArray* matches = [@"55 or 99 spiders" matchesWithDetails:RX(@"\\d+")];
    // => @[ RxMatch, RxMatch ]

    NSArray* matches = [RX(@"\\d+") matchesWithDetails:@"55 or 99 spiders"];
    // => @[ RxMatch, RxMatch ]


<a name="replace"/>
##Replace

###### Replace With Template

Replace allows you to replace matched substrings with a templated string.

    NSString* result = [RX(@"ruf+") replace:@"ruf ruff!" with:@"meow"];
    // => @"meow meow!"

###### Replace With Block

Replace with block lets you pass an objective-c block that returns the replacement `NSString`. The block receives an `NSString` which is the matched substring.

    NSString* result = [RX(@"[A-Z]+") replace:@"i love COW" withBlock:^(NSString*){ return @"lamp"; }];
    // => @"i love lamp"


###### Replace With Details Block 

Similar to replace with block, but this block receives an [RxMatch](#rxmatch) for each match. This gives you details about the match such as captured groups.

    NSString* result = [RX(@"\\w+") replace:@"two three" withDetailsBlock:^(RxMatch* match){ 
	    return [NSString stringWithFormat:@"%i", match.value.length];
	  }];
    // => @"3 5"


###### Replace From NSString

Replace can also be called from an `NSString`.

    NSString* result = [@"ruf ruff!" replaceRX(@"ruf+") with:@"meow"];
    // => @"meow meow!"
    
    NSString* result = [@"i love COW" replace:RX(@"[A-Z]+") withBlock:^(NSString*){ return @"lamp"; }];
    // => @"i love lamp"

    NSString* result = [@"two three" replace:RX(@"\\w+") withDetailsBlock:^(RxMatch* match){ 
        return [NSString stringWithFormat:@"%i", match.value.length];
    }];
    // => @"3 5"


<a name="rxmatch"/>
## RxMatch Objects

`RxMatch` and `RxMatchGroup` are objects that contain information about a match and its groups.

```objc
@interface RxMatch : NSObject

	/* The substring that matched the expression. */
	@property (retain) NSString* value;    

	/* The range of the original string that was matched. */
	@property (assign) NSRange   range;    

	/* Each object is an RxMatchGroup. */
	@property (retain) NSArray*  groups;   

	/* The full original string that was matched against.  */
	@property (retain) NSString* original; 

@end

@interface RxMatchGroup : NSObject

   /* The substring matched for the group. */
	@property (retain) NSString* value;
	
   /* The range of the captured group, relative to the original string. */
	@property (assign) NSRange range;
		
@end
```


<a name="support"/>
## Support

If you need help, [submit an issue](https://github.com/bendytree/Objective-C-RegEx-Categories/issues) or send a [pull request](https://github.com/bendytree/Objective-C-RegEx-Categories/pulls). Please include appropriate unit tests in any pull requests.

You can visit my website at [joshwright.com](http://joshwright.com) or tweet at me [@BendyTree](http://twitter.com/bendytree).


<a name="licensing"/>
## Licensing

[MIT License](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/LICENSE.txt) - do whatever you want, just (1) provide attribution and (2) don't hold me liable.


<a name="testing"/>
## Testing

This repository includes unit tests written in the [XCTest](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTestYourApp/UnitTestYourApp.html) framework. 


<a name="alternatives"/>
## Alternatives

There are a few other options for using regular expressions in objective-c including:

 - Raw [NSRegularExpression](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSRegularExpression_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009708) - Built in to Foundation since OSX 10.7 and iOS 4.0.
 - [RegexKitLite](http://regexkit.sourceforge.net/RegexKitLite/) - Bridge between NSString and [ICU Regex](http://site.icu-project.org/)
 - [CocoaRegex](https://github.com/psychs/cocoaregex) - Alternative bridge to ICU



<a name="whousesit"/>
## Who Uses It?

Here is a list of projects using Objective-C RegEx Categories. If you're using it, [tweet at me](http://twitter.com/bendytree) (@BendyTree) and I'll add you to the list:

 - [Memorize Anything](https://itunes.apple.com/us/app/memorize-anything/id430219093?ls=1&mt=8)
 - [SpeakY](https://itunes.apple.com/us/app/speaky-instant-sound-system/id654845699?ls=1&mt=8)
 - [Oyster 1.2](http://www.rwe-uk.com/site/comments/oyster_1.2_the_mac_regex_tool_released)

