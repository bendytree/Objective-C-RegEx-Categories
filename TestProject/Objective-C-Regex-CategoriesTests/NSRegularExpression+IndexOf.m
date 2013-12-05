//
//  IndexOf.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSRegularExpression_IndexOf : XCTestCase @end


@implementation NSRegularExpression_IndexOf

- (void) test_indexOf_on_matching_string_returns_index_of_first_match
{
    int i = [RX(@"\\d") indexOf:@"You 2 can have 3 cows."];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

- (void) test_indexOf_on_non_matching_string_returns_negative_one
{
    int i = [RX(@"\\d") indexOf:@"You two can have three cows."];
    XCTAssertEqual(i, -1, @"Expected to match index -1.");
}

- (void) test_indexOf_on_matching_rx_returns_index_of_first_match
{
    int i = [RX(@"\\d") indexOf:@"You 2 can have 3 cows."];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

@end
