//
//  RCDataStatus.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/07.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCData;
/**
 * @brief Modelクラス
 * @auther TF
 *
 */
@interface RCDataStatus : NSManagedObject

@property (nonatomic, retain) NSDate * deadLine;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) RCData *data;

@end
