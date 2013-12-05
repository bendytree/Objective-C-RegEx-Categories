//
//  NSRegularExpression+Matches.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"


@interface NSRegularExpression_Matches : XCTestCase @end


@implementation NSRegularExpression_Matches

- (void) test_Matches_returns_an_array_of_matched_strings_without_other_match_information
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSArray* matches = [RX(@"\\w+[@]\\w+[.](\\w+)") matches:str];
    XCTAssertEqual(matches.count, 2U, @"Should have 2 matches.");
    XCTAssertEqualObjects(matches[0], @"me@example.com", @"First match should be 'me@example.com'.");
    XCTAssertEqualObjects(matches[1], @"you@example.com", @"Second match should be 'you@example.com'.");
}

- (void) test_First_match_returns_the_first_match
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSString* match = [RX(@"\\w+[@]\\w+[.](\\w+)") firstMatch:str];
    XCTAssertEqualObjects(match, @"me@example.com", @"First match should be 'me@example.com'.");
}

- (void) test_First_match_returns_nil_for_no_matches
{
    NSString* match = [RX(@"\\d") firstMatch:@"Cats and dogs."];
    XCTAssertEqualObjects(match, nil, @"Match should be nil.");
}

- (void) test_matchesWithDetails_returns_array_of_matches_with_details
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    NSArray* matches = [str matchesWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
    
    //two matches should be found
    XCTAssertEqual(matches.count, 2U, @"Should have 2 matches.");
    
    //all matches should be RxMatch objects
    for (id match in matches){
        XCTAssertEqualObjects([match class], [RxMatch class], @"Each item in the array should be a details object.");
    }
    
    //verify the first match
    RxMatch* match = matches[0];
    XCTAssertEqualObjects(match.value, @"me@example.com", @"Value should be 'me@example.com'.");
    XCTAssertEqualObjects(match.original, @"My email is me@example.com and yours is you@example.com", @"Match contains the original string.");
    XCTAssertEqual(match.range.location, 12U, @"Location should be 12.");
    XCTAssertEqual(match.range.length, 14U, @"Length should be 14.");
    XCTAssert([match.groups isKindOfClass:[NSArray class]], @"Groups should be an NSArray.");
    XCTAssertEqual(match.groups.count, 2U, @"Groups should be an NSArray.");
    
    RxMatchGroup* groupZero = (RxMatchGroup*)match.groups[0];
    XCTAssert([groupZero isKindOfClass:[RxMatchGroup class]], @"Each group is an RxMatchGroup.");
    XCTAssertEqualObjects(groupZero.value, @"me@example.com", @"First group is always the complete match.");
    XCTAssertEqual(groupZero.range.location, 12U, @"First group's range is same as match's range.");
    XCTAssertEqual(groupZero.range.length, 14U, @"First group's range is same as match's range.");
    
    RxMatchGroup* groupOne = (RxMatchGroup*)match.groups[1];
    XCTAssertEqualObjects(groupOne.value, @"com", @"Second group is the first captured group.");
    XCTAssertEqual(groupOne.range.location, 23U, @"Location should be 23.");
    XCTAssertEqual(groupOne.range.length, 3U, @"Length should be 3.");
}

- (void) test_firstMatchWithDetails_returns_an_RxMatch_object
{
    NSString* str = @"My email is me@example.com and yours is you@example.com";
    RxMatch* match = [str firstMatchWithDetails:RX(@"\\w+[@]\\w+[.](\\w+)")];
    
    XCTAssertEqualObjects(match.value, @"me@example.com", @"First match should be 'me@example.com'.");
}

- (void) test_firstMatchWithDetails_returns_nil_for_no_matches
{
    RxMatch* match = [@"Cats and dogs." firstMatchWithDetails:RX(@"\\d")];
    
    XCTAssert(match == nil, @"Match should be nil.");
}

@end
