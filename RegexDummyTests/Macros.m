//
//  Macros.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface Macros : XCTestCase @end


@implementation Macros

- (void) test_RX_is_a_macro_for_creating_an_NSRegularExpression
{
    BOOL isRx = [RX(@".") isMemberOfClass:[NSRegularExpression class]];
    XCTAssert(isRx, @"Expected RX to create a NSRegularExpression.");
}

- (void) test_Rx_is_an_alias_for_NSRegularExpression
{
    XCTAssertEqualObjects([Rx class], [NSRegularExpression class], @"Expected them to be the same class.");
}

@end
