//
//  RCUtility.h
//  SampleNetwork
//
//  Created by 古山 健司 on 12/12/29.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * @brief Utilityクラス　(Static)
 * @auther TF
 * 
 */
@interface RCUtility : NSObject
/**
 * @brief 転送フォーマット生成メソッド
 * @param [in] 
 * @return (NSData*) 
 */
+ (NSData*)createFormatData:(id)object;
/**
 * @brief UUID生成メソッド
 * @return (NSString*) UUID
 */
+ (NSString*)uuid;
@end
