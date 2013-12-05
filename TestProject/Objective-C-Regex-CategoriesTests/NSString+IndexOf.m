//
//  NSString+IndexOf.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSString_IndexOf : XCTestCase @end


@implementation NSString_IndexOf

- (void) test_indexOf_can_be_called_on_an_NSString
{
    int i = [@"You 2 can have 3 cows." indexOf:RX(@"\\d")];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

@end
