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

static NSString* ig_convert_encoding(const char *src, const char *tocode, const char *fromcode)
{
    // Open Iconv
    iconv_t cd = iconv_open(tocode, fromcode);
    if (cd < 0)
        return NULL;

    // Config Iconv - ignore illegal sequences
    int argument = 1;
    iconvctl(cd, ICONV_SET_DISCARD_ILSEQ, &argument);

    size_t ileft = strlen(src);
    size_t oleft = ileft;
    char *op, *buf;
    char *ip = (char*) src;
    int olen = ileft + 1;

    buf = malloc(olen);
    if (!buf) {
        iconv_close(cd);
        return NULL;
    }
    
    op = buf;
    
    while (iconv(cd, &ip, &ileft, &op, &oleft) == (size_t) -1) {
        if (errno == E2BIG) {
            char *newbuf;
            /* Allocate as much additional space as iconv says we need */
            newbuf = realloc(buf, olen + ileft + oleft);
            if (!newbuf) {
                free(buf);
                iconv_close(cd);
                return NULL;
            }
            buf = newbuf;
            op = buf + (olen - oleft - 1);
            olen += ileft;
            oleft += ileft;
            continue;
        }

        free(buf);
        iconv_close(cd);
        return NULL;
    }
    *(op++) = 0;

    NSString* result = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
    free(buf);
    iconv_close(cd);
    return result;
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
    // create a buffer of null terminated string
    char buffer[[data length]+1];
    [data getBytes:buffer length:[data length]];
    buffer[data.length] = 0;
    
    // convert the string
    return ig_convert_encoding(buffer, "UTF-8", [encoding UTF8String]);;
}

+(NSString*) stringWithData:(NSData*)data {
    return [[[IGAutoString alloc] init] stringWithData:data];
}

@end
