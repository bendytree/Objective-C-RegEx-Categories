//
//  Initialization.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/29/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface Initialization : XCTestCase @end


@implementation Initialization

- (void) test_RX_is_a_macro_for_creating_an_rx_object
{
    BOOL isRx = [RX(@".") isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected RX to create an Rx object.");
}

- (void) test_Rx_has_a_static_method_rx_for_creating_an_rx_object
{
    BOOL isRx = [[Rx rx:@"."] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:] to create an Rx object.");
}

- (void) test_Rx_can_be_created_using_initWithString
{
    BOOL isRx = [[[Rx alloc] initWithString:@"."] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected [Rx rx:] to create an Rx object.");
}

- (void) test_Rx_can_be_created_using_initWithNSRegularExpression
{
    NSRegularExpression* nsRegEx = [[NSRegularExpression alloc] initWithPattern:@"." options:0 error:nil];
    BOOL isRx = [[[Rx alloc] initWithNSRegularExpression:nsRegEx] isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected initWithNSRegularExpression to create an Rx object.");
}

- (void) test_Rx_can_be_created_using_category_on_NSRegularExpression
{
    NSRegularExpression* nsRegEx = [[NSRegularExpression alloc] initWithPattern:@"." options:0 error:nil];
    Rx* rx = [nsRegEx toRx];
    BOOL isRx = [rx isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected toRx on NSRegularExpression to create an Rx object.");
}

- (void) test_Rx_can_be_created_using_category_on_NSString
{
    Rx* rx = [@"." toRx];
    BOOL isRx = [rx isMemberOfClass:[Rx class]];
    XCTAssert(isRx, @"Expected toRx on NSString to create an Rx object.");
}

@end
