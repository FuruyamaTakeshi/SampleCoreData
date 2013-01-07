//
//  RCDataFactory.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/24.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCData;
/**
 * @brief RCDataを継承するオブジェクトを生成するFactory クラス
 */ 
@interface RCDataFactory : NSObject
+ (RCData*)factoryWithName:(NSString*)name;
@end
