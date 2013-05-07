//
//  IGAutoString.m
//  IGAutoUnicode
//
//  Created by Francis Chong on 7/5/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import "IGAutoString.h"
#import "UniversalDetector.h"
#import <iconv.h>
#import <string.h>

// convert encoding
char* ig_convert_encoding(const char *src, const char *tocode, const char *fromcode)
{
    iconv_t cd;
    size_t in, out, len, err;
    char *dest, *outp, *inp = (char *) src;
    
    cd = iconv_open(tocode, fromcode);
    if (cd < 0)
        return NULL;
    
    int argument = 1;
    iconvctl(cd, ICONV_SET_DISCARD_ILSEQ, &argument);
    
    in = strlen(src);
    out = len = in * 3 / 2 + 1;
    outp = dest = (char *) malloc(len);
    
    while (in > 0) {
        err = iconv(cd, &inp, &in, &outp, &out);
        if (err == (size_t)(-1)) {
            if (errno == E2BIG) {
                size_t used = outp - dest;
                len *= 2;
                
                char *newdest = (char *) realloc(dest, len);
                if (!newdest)
                    break;
                
                dest = newdest;
                outp = dest + used;
                out = len - used - 1;
            } else {
                break;
            }
        }
    }
    
    if (outp)
        *outp = '\0';
    
    iconv_close(cd);
    return dest;
}

@implementation IGAutoString

-(id) init {
    self = [super init];
    if (self) {
        self.detector = [[UniversalDetector alloc] init];
    }
    return self;
}

-(NSString*) stringWithData:(NSData*)data {
    NSString* encoding = [self.detector encodingAsStringWithData:data];
    NSString* encoded;

    // by default, use iconv
    if (encoding) {
        encoded = [IGAutoString stringWithData:data encoding:encoding];
    }
    
    // as fallback, guess it as UTF-8
    if (!encoded) {
        encoded = [NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding];
    }

    // if UTF-8 failed, try ASCII
    if (!encoded) {
        encoded = [NSString stringWithCString:[data bytes] encoding:NSASCIIStringEncoding];
    }

    return encoded;
}

+(NSString*) stringWithData:(NSData *)data encoding:(NSString*)encoding {
	char *buf = ig_convert_encoding((char*)[data bytes], "UTF-8", [encoding UTF8String]);
    if (buf) {
        NSString* result = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
        free(buf);
        return result;
    } else {
        return nil;
    }
}

+(NSString*) stringWithData:(NSData*)data {
    return [[[IGAutoString alloc] init] stringWithData:data];
}

@end
