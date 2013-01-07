//
//  RCDataFactory.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCDataFactory.h"
#import "RCEntry.h"
#import "Content.h"
#import "RCLog.h"

@implementation RCDataFactory
+ (RCData*)factoryWithName:(NSString*)name
{
    if ([name isEqualToString:@"RCEntry"]) {
        return [[[RCEntry alloc] init] autorelease];
    }
    if ([name isEqualToString:@"Content"]) {
        return [[[Content alloc] init] autorelease];
    }
    
    if ([name isEqualToString:@"RCLog"]) {
        return [[[RCLog alloc] init] autorelease];
    }
    return nil;
}
@end
