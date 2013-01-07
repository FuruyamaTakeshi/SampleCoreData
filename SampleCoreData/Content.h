//
//  Content.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RCData.h"

@class RCEntry;

@interface Content : RCData

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSDate * deadLine;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) RCEntry *entry;

@end
