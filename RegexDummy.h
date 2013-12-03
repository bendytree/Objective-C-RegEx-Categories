//
//  RegexDummy.h
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <Foundation/Foundation.h>


/********************************************************/
/*********************** MACROS *************************/
/********************************************************/

/*
 * By default, RegexDummy creates an alias for NSRegularExpression
 * called `Rx` and creates a macro `RX()` for quick regex creation.
 *
 * If you don't want these macros, add the following statement
 * before you include this library:
 *
 * #define DisableRegexDummyMacros
 */


/**
 * Creates a macro (alias) for NSRegularExpression named `Rx`.
 *
 * ie.
 * NSRegularExpression* rx = [[Rx alloc] initWithPattern:@"\d+" options:0 error:nil];
 */

#ifndef DisableRegexDummyMacros
#define Rx NSRegularExpression
#endif


/**
 * Creates a macro (alias) for NSRegularExpression named `Rx`.
 *
 * ie.
 * NSRegularExpression* rx = [[Rx alloc] initWithPattern:@"\d+" options:0 error:nil];
 */

#ifndef DisableRegexDummyMacros
#define RX(pattern) [[NSRegularExpression alloc] initWithPattern:pattern]
#endif





/**
 * Extend NSRegularExpression.
 */

@class RxMatch;

@interface NSRegularExpression (RegexDummy)


/*******************************************************/
/******************* INITIALIZATION ********************/
/*******************************************************/

/**
 * Initialize an Rx object from a string.
 *
 * ie.
 * Rx* rx = [[Rx alloc] initWithString:@"\d+"];
 */

- (NSRegularExpression*) initWithPattern:(NSString*)pattern;


/**
 * Initialize an Rx object from a string.
 *
 * ie.
 * Rx* rx = [Rx rx:@"\d+"];
 */

+ (NSRegularExpression*) rx:(NSString*)pattern;


/**
 * Initialize an Rx object from a string. By default, NSRegularExpression
 * is case sensitive, but this signature allows you to change that.
 *
 * ie.
 * Rx* rx = [Rx rx:@"\d+" ignoreCase:YES];
 */

+ (NSRegularExpression*) rx:(NSString*)pattern ignoreCase:(BOOL)ignoreCase;


/**
 * Initialize an Rx object from a string and options.
 *
 * ie.
 * Rx* rx = [Rx rx:@"\d+" options:NSRegularExpressionCaseInsensitive];
 */

+ (NSRegularExpression*) rx:(NSString*)pattern options:(NSRegularExpressionOptions)options;


/*******************************************************/
/********************** IS MATCH ***********************/
/*******************************************************/

/**
 * Returns true if the string matches the regex. May also
 * be called on NSString as [@"\d" isMatch:rx].
 *
 * ie.
 * Rx* rx = RX(@"\d+");
 * BOOL isMatch = [rx isMatch:@"Dog #1"]; // => true
 */

- (BOOL) isMatch:(NSString*)matchee;


/**
 * Returns the index of the first match of the passed string.
 *
 * ie.
 * int i = [RX(@"\d+") indexOf:@"Buy 1 dog or buy 2?"]; // => 4
 */

- (int) indexOf:(NSString*)str;


/**
 * Splits a string using the regex to identify delimeters. Returns
 * an NSArray of NSStrings.
 *
 * ie.
 * NSArray* pieces = [RX(@"[ ,]") split:@"A dog,cat"];
 *  => @[@"A", @"dog", @"cat"]
 */

- (NSArray*) split:(NSString*)str;


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
 * A category on NSString to make it easy to use
 * Rx in simple operations.
 */

@interface NSString (RegexDummy)


/**
 * Initialize an NSRegularExpression object from a string.
 *
 * ie.
 * NSRegularExpression* rx = [@"\d+" toRx];
 */

- (NSRegularExpression*) toRx;


/**
 * Initialize an NSRegularExpression object from a string with
 * a flag denoting case-sensitivity. By default, NSRegularExpression
 * is case sensitive.
 *
 * ie.
 * NSRegularExpression* rx = [@"\d+" toRxIgnoreCase:YES];
 */

- (NSRegularExpression*) toRxIgnoreCase:(BOOL)ignoreCase;


/**
 * Initialize an NSRegularExpression object from a string with options.
 *
 * ie.
 * NSRegularExpression* rx = [@"\d+" toRxWithOptions:NSRegularExpressionCaseInsensitive];
 */

- (NSRegularExpression*) toRxWithOptions:(NSRegularExpressionOptions)options;


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



@interface RxMatch : NSObject
@property (retain) NSString* value;
@property (assign) NSRange range;
@property (retain) NSArray* groups;
@property (retain) NSString* original;
@end


@interface RxMatchGroup : NSObject
@property (retain) NSString* value;
@property (assign) NSRange range;
@end


