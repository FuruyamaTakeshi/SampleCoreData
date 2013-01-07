//
//  RCLog.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RCData.h"


@interface RCLog : RCData

@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSDate * checkInTime;
@property (nonatomic, retain) NSDate * checkOutTime;
@property (nonatomic, retain) NSNumber * appBootCount;

@end
