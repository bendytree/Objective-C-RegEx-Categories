//
//  Replace.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSRegularExpression_Replace : XCTestCase @end


@implementation NSRegularExpression_Replace

- (void) test_replace_replaces_with_back_references
{
    NSString* result = [RX(@"(\\d{3}).?(\\d{3}).?(\\d{4})") replace:@"5551234567" with:@"1 ($1) $2-$3"];
    XCTAssertEqualObjects(result, @"1 (555) 123-4567", @"Expected a properly formatted phone number.");
}

- (void) test_replace_can_be_called_from_an_NSRegularExpression
{
    NSString* result = [RX(@"ruf+") replace:@"ruff ruf!" with:@"meow"];
    XCTAssertEqualObjects(result, @"meow meow!", @"Expected to replace both barks.");
}

- (void) test_replace_replaces_with_callback
{
    NSString* result = [RX(@"[A-Z]+") replace:@"i love COW" withBlock:^(NSString* match){ return @"lamp"; }];
    XCTAssertEqualObjects(result, @"i love lamp", @"Result should be 'I love lamp'.");
}

- (void) test_replace_replaces_with_nil_callback_returns_original_string
{
    NSString* result = [RX(@"[A-Z]+") replace:@"i love COW" withBlock:nil];
    XCTAssertEqualObjects(result, @"i love COW", @"Result should be unchanged.");
}

@end
