//
//  Replace.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

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

- (void) test_replace_with_details_block_can_be_called_on_NSString
{
    NSString* result = [@"hi bud" replace:RX(@"\\w+") withDetailsBlock:^(RxMatch* match){ return [NSString stringWithFormat:@"%lu", match.value.length]; }];
    XCTAssertEqualObjects(result, @"2 3", @"Result should be '2 3'.");
}

@end
