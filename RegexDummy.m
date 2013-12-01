//
//  RegexDummy.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import "RegexDummy.h"

@implementation NSRegularExpression (RegexDummy)

- (id) initWithPattern:(NSString*)pattern
{
    return [self initWithPattern:pattern options:0 error:nil];
}

+ (NSRegularExpression*) rx:(NSString*)pattern
{
    return [[self alloc] initWithPattern:pattern];
}

+ (NSRegularExpression*) rx:(NSString*)pattern ignoreCase:(BOOL)ignoreCase
{
    return [[self alloc] initWithPattern:pattern options:ignoreCase?NSRegularExpressionCaseInsensitive:0 error:nil];
}

+ (NSRegularExpression*) rx:(NSString*)pattern options:(NSRegularExpressionOptions)options
{
    return [[self alloc] initWithPattern:pattern options:options error:nil];
}

- (BOOL) isMatch:(NSString*)matchee
{
    return [self numberOfMatchesInString:matchee options:0 range:NSMakeRange(0, matchee.length)] > 0;
}

- (int) indexOf:(NSString*)matchee
{
    NSRange range = [self rangeOfFirstMatchInString:matchee options:0 range:NSMakeRange(0, matchee.length)];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSArray*) split:(NSString *)str
{
    NSRange range = NSMakeRange(0, str.length);
    
    //get locations of matches
    NSMutableArray* matchingRanges = [NSMutableArray array];
    NSArray* matches = [self matchesInString:str options:0 range:range];
    for(NSTextCheckingResult* match in matches) {
        [matchingRanges addObject:[NSValue valueWithRange:match.range]];
    }
    
    //invert ranges - get ranges of non-matched pieces
    NSMutableArray* pieceRanges = [NSMutableArray array];
    
    //add first range
    [pieceRanges addObject:[NSValue valueWithRange:NSMakeRange(0,
      (matchingRanges.count == 0 ? str.length : [matchingRanges[0] rangeValue].location))]];
    
    //add between splits ranges and last range
    for(int i=0; i<matchingRanges.count; i++){
        BOOL isLast = i+1 == matchingRanges.count;
        int startLoc = [matchingRanges[i] rangeValue].location + [matchingRanges[i] rangeValue].length;
        int endLoc = isLast ? str.length : [matchingRanges[i+1] rangeValue].location;
        [pieceRanges addObject:[NSValue valueWithRange:NSMakeRange(startLoc, endLoc-startLoc)]];
    }
    
    //use split ranges to select pieces
    NSMutableArray* pieces = [NSMutableArray array];
    for(NSValue* val in pieceRanges) {
        NSRange range = [val rangeValue];
        NSString* piece = [str substringWithRange:range];
        [pieces addObject:piece];
    }
    
    return pieces;
}

- (NSString*) replace:(NSString*)string with:(NSString*)replacement
{
    return [self stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:replacement];
}

- (NSString*) replace:(NSString*)string withBlock:(NSString*(^)(NSString* match))replacer
{
    //no replacer? just return
    if (!replacer) return string;
    
    //copy the string so we can replace subsections
    NSMutableString* result = [string mutableCopy];
    
    //get matches
    NSArray* matches = [self matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    //replace each match (right to left so indexing doesn't get messed up)
    for (int i=matches.count-1; i>=0; i--) {
        NSTextCheckingResult* match = matches[i];
        NSString* matchStr = [string substringWithRange:match.range];
        NSString* replacement = replacer(matchStr);
        [result replaceCharactersInRange:match.range withString:replacement];
    }
    
    return result;
}

- (NSString*) replace:(NSString *)string withSetsBlock:(NSString*(^)(NSArray* set))replacer
{
    return @"";
//    //no replacer? just return
//    if (!replacer) return string;
//    
//    //copy the string so we can replace subsections
//    NSMutableString* result = [string mutableCopy];
//    
//    //get matches
//    NSArray* matches = [self matchesInString:string options:0 range:NSMakeRange(0, string.length)];
//    
//    //replace each match (right to left so indexing doesn't get messed up)
//    for (int i=matches.count-1; i>=0; i--) {
//        NSTextCheckingResult* match = matches[i];
//        NSString* matchStr = [string substringWithRange:match.range];
//        NSString* replacement = replacer(matchStr);
//        [result replaceCharactersInRange:match.range withString:replacement];
//    }
//    
//    return result;
}

- (NSArray*) matches:(NSString*)str
{
    NSMutableArray* matches = [NSMutableArray array];
    
    NSArray* results = [self matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    for (NSTextCheckingResult* result in results) {
        NSString* match = [str substringWithRange:result.range];
        [matches addObject:match];
    }
    
    return matches;
}

- (NSString*) firstMatch:(NSString*)str
{
    NSTextCheckingResult* match = [self firstMatchInString:str options:0 range:NSMakeRange(0, str.length)];
    
    if (!match) return nil;
    
    return [str substringWithRange:match.range];
}

- (RxMatch*) resultToMatch:(NSTextCheckingResult*)result original:(NSString*)original
{
    RxMatch* match = [[RxMatch alloc] init];
    match.original = original;
    match.range = result.range;
    match.value = [original substringWithRange:result.range];
    
    //groups
    NSMutableArray* groups = [NSMutableArray array];
    match.groups = groups;
    for(int i=0; i<result.numberOfRanges; i++){
        RxMatchGroup* group = [[RxMatchGroup alloc] init];
        group.range = [result rangeAtIndex:i];
        group.value = [original substringWithRange:group.range];
        [groups addObject:group];
    }
    
    return match;
}

- (NSArray*) matchesWithDetails:(NSString*)str
{
    NSMutableArray* matches = [NSMutableArray array];
    
    NSArray* results = [self matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    for (NSTextCheckingResult* result in results) {
        [matches addObject:[self resultToMatch:result original:str]];
    }
    
    return matches;
}

- (RxMatch*) firstMatchWithDetails:(NSString*)str
{
    NSArray* results = [self matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    if (results.count == 0)
        return nil;
    
    return [self resultToMatch:results[0] original:str];
}

@end



@implementation NSString (RegexDummy)

- (NSRegularExpression*) toRx
{
    return [[NSRegularExpression alloc] initWithPattern:self];
}

- (NSRegularExpression*) toRxIgnoreCase:(BOOL)ignoreCase
{
    return [NSRegularExpression rx:self ignoreCase:ignoreCase];
}

- (NSRegularExpression*) toRxWithOptions:(NSRegularExpressionOptions)options
{
    return [NSRegularExpression rx:self options:options];
}

- (BOOL) isMatch:(NSRegularExpression*)rx
{
    return [rx isMatch:self];
}

- (int) indexOf:(NSRegularExpression*)rx
{
    return [rx indexOf:self];
}

- (NSArray*) split:(NSRegularExpression*)rx
{
    return [rx split:self];
}

- (NSString*) replace:(NSRegularExpression*)rx with:(NSString*)replacement
{
    return [rx replace:self with:replacement];
}

- (NSString*) replace:(NSRegularExpression *)rx withBlock:(NSString*(^)(NSString* match))replacer
{
    return [rx replace:self withBlock:replacer];
}

- (NSString*) replace:(NSRegularExpression *)rx withSetsBlock:(NSString*(^)(NSArray* set))replacer
{
    return [rx replace:self withSetsBlock:replacer];
}

- (NSArray*) matches:(NSRegularExpression*)rx
{
    return [rx matches:self];
}

- (NSString*) firstMatch:(NSRegularExpression*)rx
{
    return [rx firstMatch:self];
}

- (NSArray*) matchesWithDetails:(NSRegularExpression*)rx
{
    return [rx matchesWithDetails:self];
}

- (RxMatch*) firstMatchWithDetails:(NSRegularExpression*)rx
{
    return [rx firstMatchWithDetails:self];
}

@end



@implementation RxMatch
@synthesize value, range, groups, original;
@end

@implementation RxMatchGroup
@synthesize value, range;
@end

