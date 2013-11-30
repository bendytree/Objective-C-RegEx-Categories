//
//  RegexDummy.h
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 * A macro for creating an Rx object from a string.
 * Shorthand for initWithString:. [Rx rx:@"."] is another option.
 *
 * ie.
 * Rx* rx = RX(@"\d+");
 *
 */

#define RX(pattern) [Rx rx:pattern]



/**
 * `Rx` is a class that wraps NSRegularExpression to simplify
 * common operations.
 */

@interface Rx : NSObject


/*******************************************************/
/******************* INITIALIZATION ********************/
/*******************************************************/

/**
 * Initialize an Rx object from a string.
 *
 * ie.
 * Rx* rx = [[Rx alloc] initWithString:@"\d+"];
 *
 * More concise initialization methods exist such as:
 * Rx* rx = RX(@"\d+");
 * Rx* rx = [Rx rx:@"\d+"];
 */

- (Rx*) initWithString:(NSString*)pattern;


/**
 * Initialize an Rx object from an NSRegularExpression.
 *
 * ie.
 * NSRegularExpression* nsRegEx = [[NSRegularExpression alloc] initWithPattern:@"." options:0 error:nil];
 * Rx* rx = [[Rx alloc] initWithNSRegularExpression:nsRegEx];
 */

- (Rx*) initWithNSRegularExpression:(NSRegularExpression*)nsRegExp;


/**
 * Initialize an Rx object from a string. Shorthand for
 * initWithString:. RX(@".") is another option.
 *
 * ie.
 * Rx* rx = [Rx rx:@"\d+"];
 *
 */

+ (Rx*) rx:(NSString*)pattern;




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
 *
 */

- (BOOL) isMatch:(NSString*)matchee;


/**
 * Returns the index of the first match of the passed string.
 *
 * ie.
 * int i = [RX(@"\d+") indexOf:@"Buy 1 dog or buy 2?"]; // => 4
 *
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

- (NSString*) replace:(NSString*)str with:(NSString*)replacement;


@end



/**
 * A category on NSString to make it easy to use
 * Rx in simple operations.
 */

@interface NSString (RegexDummy)


/**
 * Initialize an Rx object from a string.
 *
 * ie.
 * Rx* rx = [@"\d+" toRx];
 */

- (Rx*) toRx;


/**
 * Returns true if the string matches the regex. May also
 * be called as on Rx as [rx isMatch:@"some string"].
 *
 * ie.
 * BOOL isMatch = [@"Dog #1" isMatch:RX(@"\d+")]; // => true
 */

- (BOOL) isMatch:(Rx*)rx;


/**
 * Returns the index of the first match according to
 * the regex passed in.
 *
 * ie.
 * int i = [@"Buy 1 dog or buy 2?" indexOf:RX(@"\d+")]; // => 4
 */

- (int) indexOf:(Rx*)rx;


/**
 * Splits a string using the regex to identify delimeters. Returns
 * an NSArray of NSStrings.
 *
 * ie.
 * NSArray* pieces = [@"A dog,cat" split:RX(@"[ ,]")];
 *  => @[@"A", @"dog", @"cat"]
 */

- (NSArray*) split:(Rx*)rx;


/**
 * Replaces all occurances of a regex with a replacement string.
 *
 * ie.
 * NSString* result = [@"ruf ruff!" replace:RX(@"ruf+") with:@"meow"];
 *  => @"meow meow!"
 */

- (NSString*) replace:(Rx*)rx with:(NSString*)replacement;

@end



/**
 * Extend NSRegularExpression.
 */

@interface NSRegularExpression (RegexDummy)


/**
 * Initialize an Rx object from an NSRegularExpression.
 *
 * ie.
 * NSRegularExpression* nsRegEx = [[NSRegularExpression alloc] initWithPattern:@"." options:0 error:nil];
 * Rx* rx = [[Rx alloc] initWithNSRegularExpression:nsRegEx];
 */

- (Rx*) toRx;

@end
