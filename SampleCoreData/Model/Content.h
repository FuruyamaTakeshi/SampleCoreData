//
//  Content.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/12.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Content : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * link;

@end
