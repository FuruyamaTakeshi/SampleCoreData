//
//  RCDataFormatJSON.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "RCDataFormatJSON.h"

@implementation RCDataFormatJSON
@synthesize content = _content;

- (NSData*)createFormatData
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.content options:NSJSONWritingPrettyPrinted error:&error];
    
    return data;
}
@end
