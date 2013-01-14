//
//  RCUtility.m
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCUtility.h"

@implementation RCUtility

+ (NSData*)createFormatData:(id)object
{
    LOG_METHOD;
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    return data;
}

+ (NSString*)uuid
{
    LOG_METHOD;
    CFUUIDRef uuid;
    NSString *identifier;
    uuid = CFUUIDCreate(NULL);
    identifier = (NSString*)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return [identifier autorelease];
}
@end
