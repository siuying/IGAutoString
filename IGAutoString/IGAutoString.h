//
//  IGAutoString.h
//  IGAutoString
//
//  Created by Francis Chong on 7/5/13.
//  Copyright (c) 2013 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UniversalDetector;

@interface IGAutoString : NSObject

@property (nonatomic, strong) UniversalDetector* detector;

/**
 Should the converter attempt to use "Big5_HKSCS_1999" or "Big5_E" encoding when "Big5" is returned.
 Default YES.
 */
@property (nonatomic, assign) BOOL shouldTryBig5Variant;

/**
 Given a NSData, return NSString encoded with proper encoding.
 @param NSData* string encoded with arbitary encoding.
 @return NSString* properly decoded NSString.
 */
-(NSString*) stringWithData:(NSData*)data;

/**
 Given a NSData, return NSString encoded with proper encoding.
 @param NSData* string encoded with arbitary encoding.
 @return NSString* properly decoded NSString.
 */
+(NSString*) stringWithData:(NSData*)data;

@end
