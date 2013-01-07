//
//  ContentManager.h
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/12.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Content;
@class RCEntry;
/**
 * @brief facade Pattern　データ管理クラス（Singletonモデル）
 *
 */
@interface ContentManager : NSObject
{
    NSManagedObjectContext* _managedObjectContext;
}
@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, readonly) NSArray *contents;
/**
 * @brief getter クラスメソッド
 * @return  シングルトンインスタンス
 *
 */

+ (id)sharedInstance;
/**
 * @brief
 * @return コンテクスト
 *
 */
- (NSManagedObjectContext*)managedObjectContext;
/**
 * @brief　データ挿入メソッド
 * @return NSManagedObjectContextを返す。
 */
- (Content*)insertContent;
/**
 * @brief　データソース取得メソッド
 * @return データソースをArrayで返す。
 */
- (NSArray*)getsortedEntry;
/**
 * @brief　データソース取得メソッド
 * @return データソースをArrayで返す。
 */
- (NSArray*)getsortedStatus;
/**
 * @brief データ保存メソッド
 *
 */
- (void)save;
/**
 * @brief データ削除メソッド
 *
 */
/**
 * @brief Entry新規追加メソッド
 *
 */
- (RCEntry*)insertNewEntry;
/**
 * @brief debug用メソッド
 *
 */
- (void)check;

@end
