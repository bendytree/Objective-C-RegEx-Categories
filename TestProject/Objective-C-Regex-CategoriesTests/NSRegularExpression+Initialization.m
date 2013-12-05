//
//  Initialization.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSRegularExpression_Initialization : XCTestCase @end


@implementation NSRegularExpression_Initialization

- (void) test_NSRegularExpression_can_be_created_using_class_method_rx
{
    BOOL isRx = [[Rx rx:@"."] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:] to create an Rx object.");
}

- (void) test_NSRegularExpression_can_be_created_using_class_method_rx_with_casing
{
    BOOL isRx = [[Rx rx:@"." ignoreCase:YES] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:ignoreCase:] to create an Rx object.");
}

- (void) test_NSRegularExpression_can_be_created_using_class_method_rx_with_options
{
    BOOL isRx = [[Rx rx:@"." options:NSRegularExpressionCaseInsensitive] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:options:] to create an Rx object.");
}

- (void) test_NSRegularExpression_can_be_created_using_initWithPattern
{
    BOOL isRx = [[[Rx alloc] initWithPattern:@"."] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:] to create an Rx object.");
}

@end
