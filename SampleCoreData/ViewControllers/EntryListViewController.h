//
//  EntryListViewController.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryListViewController : UITableViewController

@property (nonatomic, readonly) NSArray* dataSource;
/**
 * @brief 簡易コンストラクタ
 * @param [in] entry
 * @return id
 */
- (id)initWithEntries:(id)entries;
@end
