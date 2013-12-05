//
//  NSString+Matches.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSString_Matches : XCTestCase @end


@implementation NSString_Matches

- (void) test_Matches_can_be_called_as_a_category_on_NSString
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSArray* matches = [str matches:RX(@"\\w+[@]\\w+[.](\\w+)")];
    XCTAssertEqual(matches.count, 2U, @"Should have 2 matches.");
    XCTAssertEqualObjects(matches[0], @"me@example.com", @"First match should be 'me@example.com'.");
    XCTAssertEqualObjects(matches[1], @"you@example.com", @"Second match should be 'you@example.com'.");
}

- (void) test_First_match_can_be_called_as_a_category_on_NSString
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSString* match = [str firstMatch:RX(@"\\w+[@]\\w+[.](\\w+)")];
    XCTAssertEqualObjects(match, @"me@example.com", @"First match should be 'me@example.com'.");
}

- (void) test_matchesWithDetails_can_be_called_as_a_category_on_NSString
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSArray* matches = [str matchesWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
    
    //two matches should be found
    XCTAssertEqual(matches.count, 2U, @"Should have 2 matches.");
    
    //all matches should be RxMatch objects
    for (id match in matches){
        XCTAssertEqualObjects([match class], [RxMatch class], @"Each item in the array should be a details object.");
    }
    
    //full verification is done in NSRegularExpression+Matches.m
}

- (void) test_firstMatchWithDetails_can_be_called_as_a_category_on_NSString
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    RxMatch* match = [str firstMatchWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
    
    XCTAssertEqualObjects(match.value, @"me@example.com", @"First match should be 'me@example.com'.");
}

@end
