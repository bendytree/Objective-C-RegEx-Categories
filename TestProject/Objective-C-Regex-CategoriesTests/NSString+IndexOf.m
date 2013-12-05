//
//  NSString+IndexOf.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "Objective-C-Regex-Categories.h"

@interface NSString_IndexOf : XCTestCase @end


@implementation NSString_IndexOf

- (void) test_indexOf_can_be_called_on_an_NSString
{
    unsigned long i = [@"You 2 can have 3 cows." indexOf:RX(@"\\d")];
    XCTAssertEqual(i, 4ul, @"Expected to match index 4.");
}

@end
