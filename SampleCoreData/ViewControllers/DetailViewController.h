//
//  DetailViewController.h
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCEntry;
@interface DetailViewController : UITableViewController
@property (nonatomic, retain) RCEntry* entry;

/**
 * @brief 簡易コンストラクタ
 * @param [in] entry
 * @return id
 */
- (id)initWithEntry:(id)entry;
@end
