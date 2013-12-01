//
//  Replace.m
//  RegexDummy
//
//  Created by Joshua Wright on 11/30/13.
//  Copyright (c) 2013 Bendy Tree. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegexDummy.h"

@interface NSString_Replace : XCTestCase @end


@implementation NSString_Replace

- (void) test_replace_with_string_can_be_called_on_NSString
{
    NSString* result = [@"ruff ruf!" replace:RX(@"ruf+") with:@"meow"];
    XCTAssertEqualObjects(result, @"meow meow!", @"Expected to replace both barks.");
}

- (void) test_replace_with_block_can_be_called_on_NSString
{
    NSString* result = [@"i love COW" replace:RX(@"[A-Z]+") withBlock:^(NSString* match){ return @"lamp"; }];
    XCTAssertEqualObjects(result, @"i love lamp", @"Result should be 'I love lamp'.");
}

//- (void) test_replace_sets_callback_can_be_called_on_NSString
//{
//    NSString* result = [@"hi bud" replace:RX(@"(\\w)*") withSetsBlock:^(NSArray* set){ return [NSString stringWithFormat:@"%i", set.count]; }];
//    XCTAssertEqualObjects(result, @"2 3", @"Result should be '2 3'.");
//}

@end
