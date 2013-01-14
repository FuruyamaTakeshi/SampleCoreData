//
//  RCLogManager.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCData;
/**
 * @brief Log管理クラス　(Singletonモデル）
 * @auther TF
 */
@interface RCLogManager : NSObject
{
    NSManagedObjectContext* _managedObjectContext;
}
@property (nonatomic, retain) NSDate* checkInTime;
@property (nonatomic, retain) NSDate* checkOutTime;
@property (nonatomic, retain) NSString* sessionID;

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
/**
 * @brief
 * @return (id) インスタンス
 */
+ (id)log;

- (void)start;
- (void)end;
/**
 * @brief Logの書き込み
 *
 */
- (RCData *)logWithViewController:(UIViewController*)viewController;
/**
 * @brief
 *
 */
- (NSArray*)getLogs;
- (void)save;
@end
