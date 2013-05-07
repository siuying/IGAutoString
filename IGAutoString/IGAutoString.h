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
