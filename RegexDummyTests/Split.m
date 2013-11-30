//
//  Split.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface Split : XCTestCase @end


@implementation Split

- (void) test_split_string_on_regex_returns_array_of_strings
{
    NSArray* pieces = [@"I like cats,dogs" split:RX(@"[ ,]")];
    XCTAssertEqual(pieces.count, 4U, @"Expected array to contain 4 items.");
    XCTAssertEqualObjects(pieces[0], @"I", @"Expected first item to be 'I'.");
    XCTAssertEqualObjects(pieces[1], @"like", @"Expected second item to be 'I'.");
    XCTAssertEqualObjects(pieces[2], @"cats", @"Expected third item to be 'cats'.");
    XCTAssertEqualObjects(pieces[3], @"dogs", @"Expected fourth item to be 'dogs'.");
}

- (void) test_split_string_with_no_matches_returns_array_with_original_string
{
    NSArray* pieces = [@"Hey dog." split:RX(@",")];
    XCTAssertEqual(pieces.count, 1U, @"Expected array to contain 1 item.");
    XCTAssertEqualObjects(pieces[0], @"Hey dog.", @"Expected first item to be 'Hey dog.'.");
}

- (void) test_split_string_keeps_empty_entries
{
    NSArray* pieces = [@".Hey..dog." split:RX(@"[.]")];
    XCTAssertEqual(pieces.count, 5U, @"Expected array to contain 5 items.");
    XCTAssertEqualObjects(pieces[0], @"", @"Expected first item to be ''.");
    XCTAssertEqualObjects(pieces[1], @"Hey", @"Expected second item to be 'Hey'.");
    XCTAssertEqualObjects(pieces[2], @"", @"Expected third item to be ''.");
    XCTAssertEqualObjects(pieces[3], @"dog", @"Expected fourth item to be 'dog'.");
    XCTAssertEqualObjects(pieces[4], @"", @"Expected fifth item to be ''.");
}

- (void) test_split_on_regex_of_string_returns_array_of_strings
{
    NSArray* pieces = [RX(@"[ ,]") split:@"I like cats,dogs"];
    XCTAssertEqual(pieces.count, 4U, @"Expected array to contain 4 items.");
    XCTAssertEqualObjects(pieces[0], @"I", @"Expected first item to be 'I'.");
    XCTAssertEqualObjects(pieces[1], @"like", @"Expected second item to be 'I'.");
    XCTAssertEqualObjects(pieces[2], @"cats", @"Expected third item to be 'cats'.");
    XCTAssertEqualObjects(pieces[3], @"dogs", @"Expected fourth item to be 'dogs'.");
}

@end
