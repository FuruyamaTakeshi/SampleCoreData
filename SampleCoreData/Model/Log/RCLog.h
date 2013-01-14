//
//  RCLog.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RCData.h"


@interface RCLog : RCData

@property (nonatomic, retain) NSNumber * appBootCount;
@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSDate * checkOutTime;
@property (nonatomic, retain) NSNumber * isSent;
@property (nonatomic, retain) NSString * sessionID;

@end
