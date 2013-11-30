//
//  RegexDummy.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import "RegexDummy.h"

@implementation Rx {
    
    NSRegularExpression* rx;
    
}

- (id) initWithNSRegularExpression:(NSRegularExpression*)nsRegExp
{
    self = [super init];
    if (self) {
        rx = nsRegExp;
    }
    return self;
}

- (id) initWithString:(NSString*)pattern
{
    return [self initWithNSRegularExpression:[[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil]];
}

+ (Rx*) rx:(NSString*)pattern
{
    return [[Rx alloc] initWithString:pattern];
}

- (BOOL) isMatch:(NSString*)matchee
{
    return [rx numberOfMatchesInString:matchee options:0 range:NSMakeRange(0, matchee.length)] > 0;
}

- (int) indexOf:(NSString*)matchee
{
    NSRange range = [rx rangeOfFirstMatchInString:matchee options:0 range:NSMakeRange(0, matchee.length)];
    return range.location == NSNotFound ? -1 : range.location;
}

- (NSArray*) split:(NSString *)str
{
    NSRange range = NSMakeRange(0, str.length);
    
    //get locations of matches
    NSMutableArray* matchingRanges = [NSMutableArray array];
    NSArray* matches = [rx matchesInString:str options:0 range:range];
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

- (NSString*) replace:(NSString*)str with:(NSString*)replacement
{
    return [rx stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:replacement];
}

@end



@implementation NSString (RegexDummy)

- (Rx*) toRx
{
    return [Rx rx:self];
}

- (BOOL) isMatch:(Rx*)rx
{
    return [rx isMatch:self];
}

- (int) indexOf:(Rx*)rx
{
    return [rx indexOf:self];
}

- (NSArray*) split:(Rx*)rx
{
    return [rx split:self];
}

- (NSString*) replace:(Rx*)rx with:(NSString*)replacement
{
    return [rx replace:self with:replacement];
}

@end



@implementation NSRegularExpression (RegexDummy)

- (Rx*) toRx
{
    return [[Rx alloc] initWithNSRegularExpression:self];
}

@end
