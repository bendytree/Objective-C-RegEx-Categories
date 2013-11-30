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

- (void) test_regex_replace_replaces_with_back_references
{
    NSString* result = [@"5551234567" replace:RX(@"(\\d{3}).?(\\d{3}).?(\\d{4})") with:@"1 ($1) $2-$3"];
    XCTAssertEqualObjects(result, @"1 (555) 123-4567", @"Expected a properly formatted phone number.");
}

- (void) test_regex_replace_is_case_sensitive
{
    NSString* result = [@"Dogs are dogs." replace:RX(@"dogs") with:@"cats"];
    XCTAssertEqualObjects(result, @"Dogs are cats.", @"Expected replace to ignore casing.");
}

- (void) test_replace_on_regex_replaces_all_occurances
{
    NSString* result = [RX(@"ruf+") replace:@"ruff ruf!" with:@"meow"];
    XCTAssertEqualObjects(result, @"meow meow!", @"Expected to replace both barks.");
}

@end
