#Table of Contents

 - Introduction
 - Quick Examples
 - Macros
 - Creation
 - Test If Match
 - Index Of Match


# Introduction

This project makes regular expressions easy and concise in Objective-C.

As of iOS4 (and OSX10.7), `NSRegularExpression` was built in to the Foundation framework. The syntax is somewhat cumbersome, so this library creates categories and macros to simplify regex usage. 

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

**PRO TIP:** See the header ([RegExCategories.h](https://github.com/bendytree/Objective-C-RegEx-Categories/blob/master/RegExCategories.h)) for more details and examples.


# Quick Examples

Here's are some quick examples of how you might use the code.


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
```


# Macros

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
#inclue "RegExCategories.h"
```


# Creation

Here are a few convenient ways to create an `NSRegularExpression`.


####Class Method - rx

    Rx* rx = [Rx rx:@"\\d+"];

####Class Method - ignore case

    Rx* rx = [Rx rx:@"\\d+" ignoreCase:YES];

####Class Method - with options

    Rx* rx = [Rx rx:@"\\d+" options:NSRegularExpressionCaseInsensitive];

####Init With Pattern

    Rx* rx = [[Rx alloc] initWithPattern:@"\d+"];

####String Extension

	Rx* rx = [@"\\d+" toRx];

####String Extension - ignore case

	Rx* rx = [@"\\d+" toRxIgnoreCase:YES];

####String Extension - with options

	Rx* rx = [@"\\d+" toRxWithOptions:NSRegularExpressionCaseInsensitive];


#Test If Match

####From NSRegularExpression

    BOOL isMatch = [RX(@"\\d+") isMatch:@"Dog #1"];
    // => true

####From NSString

    BOOL isMatch = [@"Dog #1" isMatch:RX(@"\\d+")];
    // => true


#Index Of Match

####From NSRegularExpression

    int index = [RX(@"\\d+") indexOf:@"Buy 1 dog or buy 2?"];
    // => 4

    int index = [RX(@"\\d+") indexOf:@"Buy a dog?"];
    // => -1

####From NSString

    int index = [@"Buy 1 dog or buy 2?" indexOf:RX(@"\\d+")];
    // => 4

    int index = [@"Buy a dog?" indexOf:RX(@"\\d+")];
    // => -1


#Split A String

####From NSRegularExpression

    NSArray* pieces = [RX(@"[ ,]") split:@"A dog,cat"];
    // => @[@"A", @"dog", @"cat"]


####From NSString

    NSArray* pieces = [@"A dog,cat" split:RX(@"[ ,]")];
    // => @[@"A", @"dog", @"cat"]


#Replace





/**
 * Replaces all occurances in a string with a replacement string.
 *
 * ie.
 * NSString* result = [RX(@"ruf+") replace:@"ruf ruff!" with:@"meow"];
 *  => @"meow meow!"
 */

- (NSString*) replace:(NSString*)string with:(NSString*)replacement;


/**
 * Replaces all occurances of a regex using a block. The block receives the match
 * and should return the replacement.
 *
 * ie.
 * NSString* result = [RX(@"[A-Z]+") replace:@"i love COW" withBlock:^(NSString*){ return @"lamp"; }];
 *  => @"i love lamp"
 */

- (NSString*) replace:(NSString*)string withBlock:(NSString*(^)(NSString* match))replacer;


/**
 * Replaces all occurances of a regex using a block. The block receives a RxMatch object
 * that contains all the details of the match and should return a string
 * which is what the match is replaced with.
 *
 * ie.
 * NSString* result = [RX(@"\\w+") replace:@"hi bud" withBlock:^(RxMatch* match){ return [NSString stringWithFormat:@"%i", match.value.length]; }];
 *  => @"2 3"
 */

- (NSString*) replace:(NSString *)string withDetailsBlock:(NSString*(^)(RxMatch* match))replacer;


/**
 * Returns an array of matched root strings with no other match information.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSArray* matches = [RX(@"\\w+[@]\\w+[.](\\w+)") matches:str];
 *  => @[ @"me@example.com", @"you@example.com" ]
 */

- (NSArray*) matches:(NSString*)str;


/**
 * Returns a string which is the first match of the NSRegularExpression.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSString* match = [RX(@"\\w+[@]\\w+[.](\\w+)") firstMatch:str];
 *  => @"me@example.com"
 */

- (NSString*) firstMatch:(NSString*)str;


/**
 * Returns an NSArray of RxMatch* objects. Each match contains the matched
 * value, range, groups, etc.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSArray* matches = [str matchesWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
 */

- (NSArray*) matchesWithDetails:(NSString*)str;


/**
 * Returns the first match as an RxMatch* object.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * Rx* rx = RX(@"\\w+[@]\\w+[.](\\w+)");
 * RxMatch* match = [rx firstMatchWithDetails:str];
 */

- (RxMatch*) firstMatchWithDetails:(NSString*)str;

@end






/**
 * Returns true if the string matches the regex. May also
 * be called as on Rx as [rx isMatch:@"some string"].
 *
 * ie.
 * BOOL isMatch = [@"Dog #1" isMatch:RX(@"\d+")]; // => true
 */

- (BOOL) isMatch:(NSRegularExpression*)rx;


/**
 * Returns the index of the first match according to
 * the regex passed in.
 *
 * ie.
 * int i = [@"Buy 1 dog or buy 2?" indexOf:RX(@"\d+")]; // => 4
 */

- (int) indexOf:(NSRegularExpression*)rx;


/**
 * Splits a string using the regex to identify delimeters. Returns
 * an NSArray of NSStrings.
 *
 * ie.
 * NSArray* pieces = [@"A dog,cat" split:RX(@"[ ,]")];
 *  => @[@"A", @"dog", @"cat"]
 */

- (NSArray*) split:(NSRegularExpression*)rx;


/**
 * Replaces all occurances of a regex with a replacement string.
 *
 * ie.
 * NSString* result = [@"ruf ruff!" replace:RX(@"ruf+") with:@"meow"];
 *  => @"meow meow!"
 */

- (NSString*) replace:(NSRegularExpression*)rx with:(NSString*)replacement;


/**
 * Replaces all occurances of a regex using a block. The block receives the match
 * and should return the replacement.
 *
 * ie.
 * NSString* result = [@"i love COW" replace:RX(@"[A-Z]+") withBlock:^(NSString*){ return @"lamp"; }];
 *  => @"i love lamp"
 */

- (NSString*) replace:(NSRegularExpression *)rx withBlock:(NSString*(^)(NSString* match))replacer;


/**
 * Replaces all occurances of a regex using a block. The block receives an RxMatch
 * object which contains all of the details for each match and should return a string
 * which is what the match is replaced with.
 *
 * ie.
 * NSString* result = [@"hi bud" replace:RX(@"\\w+") withDetailsBlock:^(RxMatch* match){ return [NSString stringWithFormat:@"%i", match.value.length]; }];
 *  => @"2 3"
 */

- (NSString*) replace:(NSRegularExpression *)rx withDetailsBlock:(NSString*(^)(RxMatch* match))replacer;


/**
 * Returns an array of matched root strings with no other match information.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSArray* matches = [str matches:RX(@"\\w+[@]\\w+[.](\\w+)")];
 *  => @[ @"me@example.com", @"you@example.com" ]
 */

- (NSArray*) matches:(NSRegularExpression*)rx;


/**
 * Returns a string which is the first match of the NSRegularExpression.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSString* match = [str firstMatch:RX(@"\\w+[@]\\w+[.](\\w+)")];
 *  => @"me@example.com"
 */

- (NSString*) firstMatch:(NSRegularExpression*)rx;


/**
 * Returns an NSArray of RxMatch* objects. Each match contains the matched
 * value, range, groups, etc.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * NSArray* matches = [str matchesWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
 */

- (NSArray*) matchesWithDetails:(NSRegularExpression*)rx;


/**
 * Returns an the first match as an RxMatch* object.
 *
 * ie.
 * NSString* str = @"My email is me@example.com and yours is you@example.com";
 * RxMatch* match = [str firstMatchWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
 */

- (RxMatch*) firstMatchWithDetails:(NSRegularExpression*)rx;

@end


# Match Objects


/**
 * RxMatch represents a single match. It contains the
 * matched value, range, sub groups, and the original
 * string.
 */

@interface RxMatch : NSObject
@property (retain) NSString* value;    /* The substring that matched the expression. */
@property (assign) NSRange   range;    /* The range of the original string that was matched. */
@property (retain) NSArray*  groups;   /* Each object is an RxMatchGroup. */
@property (retain) NSString* original; /* The full original string that was matched against.  */
@end


@interface RxMatchGroup : NSObject
@property (retain) NSString* value;
@property (assign) NSRange range;
@end