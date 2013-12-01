//
//  NSString+IsMatch.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSString_IsMatch : XCTestCase @end


@implementation NSString_IsMatch

- (void) test_isMatch_can_be_called_on_an_NSString
{
    BOOL isMatch = [@"I am a dog." isMatch:RX(@".at")];
    XCTAssert(!isMatch, @"Expected isMatch to return false.");
}

@end
