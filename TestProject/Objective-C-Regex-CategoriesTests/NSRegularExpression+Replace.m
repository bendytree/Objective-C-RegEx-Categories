//
//  Replace.m
//  Objective-C-Regex-Categories
//


#import <XCTest/XCTest.h>
#import "RegExCategories.h"

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

- (void) test_replace_replaces_with_sets_callback
{
    NSString* result = [RX(@"\\w+") replace:@"hi bud" withDetailsBlock:^(RxMatch* match){ return [NSString stringWithFormat:@"%lu", (unsigned long)match.value.length]; }];
    XCTAssertEqualObjects(result, @"2 3", @"Result should be '2 3'.");
}

- (void) test_replace_replaces_with_nil_sets_callback_returns_original_string
{
    NSString* result = [RX(@".") replace:@"hi bud" withDetailsBlock:nil];
    XCTAssertEqualObjects(result, @"hi bud", @"Result should be the original string.");
}

@end
