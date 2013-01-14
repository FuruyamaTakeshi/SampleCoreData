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
@class RCDataStatus;
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
+ (id)sharedManager;
/**
 * @brief
 * @return コンテクスト
 *
 */
- (NSManagedObjectContext*)managedObjectContext;
/**
 * @brief Entry新規追加メソッド
 *
 */
- (RCEntry*)insertNewEntry;

/**
 * @brief　データ挿入メソッド
 * @return NSManagedObjectContextを返す。
 */
- (RCDataStatus*)insertNewStatusAtIndex:(int)index;

- (RCDataStatus*)insertNewStatusToEntry:(id)anEntry;

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
 * @brief debug用メソッド
 *
 */
- (void)check;
/**
 * @brief ステータス取得メソッド
 * @param [in] 対象Entryのindex
 * @return ステータス一覧を格納したArrayを返す。
 */
- (NSArray*)getsortedStatusAtIndex:(int)index;
/**
 * @brief ステータス取得メソッド
 * @param [in] 対象Entryインスタンス
 * @return ステータス一覧を格納したArrayを返す。
 */
- (NSArray*)getsortedStatusesOfAnEntry:(id)entry;
@end
