//
//  IndexOf.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface IndexOf : XCTestCase @end

@implementation IndexOf

- (void) test_indexOf_on_matching_string_returns_index_of_first_match
{
    int i = [@"You 2 can have 3 cows." indexOf:RX(@"\\d")];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

- (void) test_indexOf_on_non_matching_string_returns_negative_one
{
    int i = [@"You two can have three cows." indexOf:RX(@"\\d")];
    XCTAssertEqual(i, -1, @"Expected to match index -1.");
}

- (void) test_indexOf_on_matching_rx_returns_index_of_first_match
{
    int i = [RX(@"\\d") indexOf:@"You 2 can have 3 cows."];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

@end
