//
//  Split.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSString_Split : XCTestCase @end


@implementation NSString_Split

- (void) test_split_can_be_called_from_an_NSString
{
    NSArray* pieces = [@"I like cats,dogs" split:RX(@"[ ,]")];
    XCTAssertEqual(pieces.count, 4U, @"Expected array to contain 4 items.");
}

@end
