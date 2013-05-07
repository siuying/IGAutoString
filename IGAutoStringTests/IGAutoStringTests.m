//
//  IGAutoUnicodeTests.m
//  IGAutoUnicodeTests
//
//  Created by Francis Chong on 7/5/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "IGAutoString.h"

@interface IGAutoStringTests : SenTestCase
@property (nonatomic, strong) IGAutoString* unicode;
@end

@implementation IGAutoStringTests

- (void)setUp
{
    [super setUp];

    self.unicode = [[IGAutoString alloc] init];
}

- (void)tearDown
{
    self.unicode = nil;
    [super tearDown];
}

+ (NSData*) fixtureWithResource:(NSString*) resource {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [bundle pathForResource:resource ofType:@"html"];
    return [NSData dataWithContentsOfMappedFile:path];
}

- (void)testConversion
{
    NSDictionary* fixtures = @{
                               @"mingpao": @"湯顯明5年收禮450份",
                               @"moe": @"草木初生的芽",
                               @"ascii": @"PC graphics hardware is built around using an 8-bit code page",
                               @"jijicom": @"川口氏は４月、中国出張から予定通りに帰国せず",
                               @"theverge": @"The Flex tracks your sleep much like the Up, though with far less power.",
                               @"yomiuri": @"群馬県下仁田町南野牧の荒船山（１４２３メートル）"
                               };

    [fixtures enumerateKeysAndObjectsUsingBlock:^(NSString* res, NSString* content, BOOL *stop) {
        NSData* data = [IGAutoUnicodeTests fixtureWithResource:res];
        NSString* string = [self.unicode stringWithData:data];
        STAssertNotNil(string, nil);
        STAssertTrue(([string rangeOfString:content].location != NSNotFound), [NSString stringWithFormat:@"\"%@\" not found", content]);
    }];
}

@end
