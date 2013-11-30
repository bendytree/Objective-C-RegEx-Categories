//
//  IsMatch.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface IsMatch : XCTestCase @end

@implementation IsMatch

- (void) test_is_match_returns_false_for_zero_matches
{
    BOOL isMatch = [RX(@".at") isMatch:@"I am a dog."];
    XCTAssert(!isMatch, @"Expected isMatch to return false.");
}

- (void) test_is_match_returns_true_for_one_match
{
    BOOL isMatch = [RX(@".at") isMatch:@"I know a cat."];
    XCTAssert(isMatch, @"Expected isMatch to return true.");
}

- (void) test_is_match_returns_true_for_multiple_matches
{
    BOOL isMatch = [RX(@".at") isMatch:@"I eat cats."];
    XCTAssert(isMatch, @"Expected isMatch to return true.");
}

- (void) test_is_match_NSString_category_returns_false_for_zero_matches
{
    BOOL isMatch = [@"I am a dog." isMatch:RX(@".at")];
    XCTAssert(!isMatch, @"Expected isMatch to return false.");
}

- (void) test_is_match_NSString_category_returns_false_for_multiple_matches
{
    BOOL isMatch = [@"I eat cats." isMatch:RX(@".at")];
    XCTAssert(isMatch, @"Expected isMatch to return true.");
}

@end
