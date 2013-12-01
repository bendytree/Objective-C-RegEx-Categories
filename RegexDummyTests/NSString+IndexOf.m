//
//  NSString+IndexOf.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSString_IndexOf : XCTestCase @end


@implementation NSString_IndexOf

- (void) test_indexOf_can_be_called_on_an_NSString
{
    int i = [@"You 2 can have 3 cows." indexOf:RX(@"\\d")];
    XCTAssertEqual(i, 4, @"Expected to match index 4.");
}

@end
