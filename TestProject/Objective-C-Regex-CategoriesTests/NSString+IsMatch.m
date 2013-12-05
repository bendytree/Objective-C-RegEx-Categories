//
//  NSString+IsMatch.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

@interface NSString_IsMatch : XCTestCase @end


@implementation NSString_IsMatch

- (void) test_isMatch_can_be_called_on_an_NSString
{
    BOOL isMatch = [@"I am a dog." isMatch:RX(@".at")];
    XCTAssert(!isMatch, @"Expected isMatch to return false.");
}

@end
