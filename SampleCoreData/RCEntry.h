//
//  RCEntry.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RCData.h"

@class Content;

@interface RCEntry : RCData

@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * thumnail;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * entryStatus;
@property (nonatomic, retain) NSSet *contents;
@end

@interface RCEntry (CoreDataGeneratedAccessors)

- (void)addContentsObject:(Content *)value;
- (void)removeContentsObject:(Content *)value;
- (void)addContents:(NSSet *)values;
- (void)removeContents:(NSSet *)values;

@end
