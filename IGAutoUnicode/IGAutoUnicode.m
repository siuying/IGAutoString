//
//  IGAutoUnicode.m
//  IGAutoUnicode
//
//  Created by Francis Chong on 7/5/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "IGAutoUnicode.h"
#import "UniversalDetector.h"

@implementation IGAutoUnicode

-(id) init {
    self = [super init];
    if (self) {
        self.shouldTryBig5Variant = YES;
        self.detector = [[UniversalDetector alloc] init];
    }
    return self;
}

-(NSString*) stringWithData:(NSData*)data {
    CFStringEncodings encoding = [self.detector detectEncoding:data];
    NSString* encoded;

    // if encoding invalid/ascii, try UTF-8 anyway
    if (encoding == kCFStringEncodingInvalidId) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    

    // if encoding is Big5, try possible variants first
    if (self.shouldTryBig5Variant && encoding == kCFStringEncodingBig5) {
        if (!encoded) {
            encoded = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5_HKSCS_1999)];
        }
        if (!encoded) {
            encoded = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5_E)];
        }
    }

    // by default, use whatever encoding we guessed
    if (!encoded) {
        NSStringEncoding nsEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        encoded = [[NSString alloc] initWithData:data encoding:nsEncoding];
    }

    return encoded;
}

+(NSString*) stringWithData:(NSData*)data {
    return [[[IGAutoUnicode alloc] init] stringWithData:data];
}

@end
