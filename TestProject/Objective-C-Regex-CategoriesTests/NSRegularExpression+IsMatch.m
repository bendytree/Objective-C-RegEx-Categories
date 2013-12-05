//
//  IsMatch.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSRegularExpression_IsMatch : XCTestCase @end


@implementation NSRegularExpression_IsMatch

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

- (void) test_is_match_defaults_to_being_case_sensitive
{
    BOOL isMatch = [RX(@"dog") isMatch:@"Dogs are nice."];
    XCTAssert(!isMatch, @"Expected isMatch to return false.");
}

- (void) test_is_match_can_be_case_insensitive_using_options
{
    NSRegularExpression* rx = [[NSRegularExpression alloc] initWithPattern:@"dog" options:NSRegularExpressionCaseInsensitive error:nil];
    BOOL isMatch = [rx isMatch:@"Dogs are nice."];
    XCTAssert(isMatch, @"Expected isMatch to return true.");
}

@end
