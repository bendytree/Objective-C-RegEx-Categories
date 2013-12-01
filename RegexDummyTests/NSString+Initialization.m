//
//  NSString+Initialization.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSString_Initialization : XCTestCase @end


@implementation NSString_Initialization

- (void) test_NSRegularExpression_can_be_created_using_category_on_NSString
{
    Rx* rx = [@"." toRx];
    BOOL isRx = [rx isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected toRx on NSString to create an Rx object.");
}

- (void) test_NSRegularExpression_can_be_created_using_category_on_NSString_and_ignoreCase
{
    Rx* rx = [@"." toRxIgnoreCase:YES];
    BOOL isRx = [rx isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected toRxIgnoreCase: on NSString to create an Rx object.");
}

- (void) test_NSRegularExpression_can_be_created_using_category_on_NSString_with_options
{
    Rx* rx = [@"." toRxWithOptions:NSRegularExpressionCaseInsensitive];
    BOOL isRx = [rx isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected toRxIgnoreCase: on NSString to create an Rx object.");
}

@end
