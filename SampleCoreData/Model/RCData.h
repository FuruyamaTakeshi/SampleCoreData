//
//  RCData.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/10.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RCDataStatus;
/**
 * @brief Modelクラス
 * @auther TF
 *
 */
@interface RCData : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *contents;
@end

@interface RCData (CoreDataGeneratedAccessors)

- (void)addContentsObject:(RCDataStatus *)value;
- (void)removeContentsObject:(RCDataStatus *)value;
- (void)addContents:(NSSet *)values;
- (void)removeContents:(NSSet *)values;

@end
