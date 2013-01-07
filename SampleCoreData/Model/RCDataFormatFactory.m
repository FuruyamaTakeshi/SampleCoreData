//
//  RCDataFormatFactory.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCDataFormatFactory.h"
#import "RCDataFormatJSON.h"
@implementation RCDataFormatFactory

+ (RCDataFormat *)factoryWithName:(NSString*)name
{
    if ([name isEqualToString:@"JSON"]) {
        return [[RCDataFormatJSON alloc] init];
    }
    return nil;
}

@end
