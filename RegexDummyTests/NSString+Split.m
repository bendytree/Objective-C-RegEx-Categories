//
//  Split.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSString_Split : XCTestCase @end


@implementation NSString_Split

- (void) test_split_can_be_called_from_an_NSString
{
    NSArray* pieces = [@"I like cats,dogs" split:RX(@"[ ,]")];
    XCTAssertEqual(pieces.count, 4U, @"Expected array to contain 4 items.");
}

@end
