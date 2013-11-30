//
//  Replace.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface Replace : XCTestCase @end


@implementation Replace

- (void) test_regex_replace_replaces_all_occurances
{
    NSString* result = [@"ruff ruf!" replace:RX(@"ruf+") with:@"meow"];
    XCTAssertEqualObjects(result, @"meow meow!", @"Expected to replace both barks.");
}

- (void) test_replace_on_regex_replaces_all_occurances
{
    NSString* result = [RX(@"ruf+") replace:@"ruff ruf!" with:@"meow"];
    XCTAssertEqualObjects(result, @"meow meow!", @"Expected to replace both barks.");
}

@end
