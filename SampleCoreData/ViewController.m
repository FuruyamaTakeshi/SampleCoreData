//
//  ViewController.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/12.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import "ViewController.h"
#import "EntryListViewController.h"
#import "ContentManager.h"

#import "Content.h"
#import "RCEntry.h"
#import "RCDataStatus.h"

#import "RCLogManager.h"
#import "RCLogViewController.h"

/**
 * @brief メイン画面ViewControllerクラスのカテゴリ（privateメソッド)
 *
 */
@interface ViewController ()

/**
 * @brief ボタンが押されたときのアクション　データベースにコンテントを追加する。
 */
- (void)addContentButtonDidPush;
/**
 * @brief ボタンが押されたときのアクション　データベースからデータを取得して、コンソールに出力する。
 */
- (void)dataFetchButtonDidPush;
@end

@implementation ViewController

- (void)viewDidLoad
{
    LOG_METHOD;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *addContentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addContentButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 40, 120, 40);
    [addContentButton setTitle:@"add Data" forState:UIControlStateNormal];
    [addContentButton addTarget:self action:@selector(addContentButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addContentButton];
    
    UIButton *addEntryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addEntryButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 100, 120, 40);
    [addEntryButton setTitle:@"add Entry" forState:UIControlStateNormal];
    [addEntryButton addTarget:self action:@selector(addEntryButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addEntryButton];
    
    UIButton *dataFetchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataFetchButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 150, 120, 40);
    [dataFetchButton setTitle:@"data Fetch" forState:UIControlStateNormal];
    [dataFetchButton addTarget:self action:@selector(dataFetchButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dataFetchButton];
    
    UIButton* logButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logButton.frame = CGRectMake((self.view.frame.size.width-120)/2, 200, 120, 40);
    [logButton setTitle:@"log" forState:UIControlStateNormal];
    [logButton addTarget:self action:@selector(logButtonDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logButton];
    
    ContentManager *mgr = [ContentManager sharedManager];    
//    NSArray* array = [mgr getsortedEntry];
//    for (Content *cont in array) {
//        NSLog(@"title:%@, %@", cont.title, cont.link);
//    }
    
    [mgr check];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[RCLogManager log] logWithViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addEntryButtonDidPush
{
    LOG_METHOD;
    int count = 0;
    count = [[NSUserDefaults standardUserDefaults] integerForKey:@"myEntryAddCount"];
    
    RCEntry* entry;
    entry = [[ContentManager sharedManager] insertNewEntry];
    entry.name = [NSString stringWithFormat:@"myEntry%d", count];
    entry.index = [NSNumber numberWithInt:count];
    entry.link = @"www.google.com";
    [[ContentManager sharedManager] save];
    count++;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"myEntryAddCount"];
    
}

- (void)addContentButtonDidPush
{
    LOG_METHOD;
    int count = 0;
    count = [[NSUserDefaults standardUserDefaults] integerForKey:@"myAddCount"];
    
    RCDataStatus* item;
    item = [[ContentManager sharedManager] insertNewStatusAtIndex:1];
    item.title = [NSString stringWithFormat:@"myItem%d", count];
    item.index = [NSNumber numberWithInt:count];
    item.link = @"http://www.yahoo.co.jp";
    [[ContentManager sharedManager] save];
    count++;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"myAddCount"];

}

- (void)dataFetchButtonDidPush
{
    LOG_METHOD;
    for (int i=0; i<2; i++) {
        NSArray* status = [[ContentManager sharedManager] getsortedStatusAtIndex:i];
        for (RCDataStatus* item in status) {
            NSLog(@"%d Status %@:index=%@", i, item.link, item.index);
        }
    }
    
    NSArray* entries = [[ContentManager sharedManager] getsortedEntry];
    
    for (RCEntry* entry in entries) {
        LOG(@"Entry %@:index=%@", entry.link, entry.index);
        NSArray* array = [[ContentManager sharedManager] getsortedStatusesOfAnEntry:entry];
        LOG(@"### %@", [array description]);
    }
    
    EntryListViewController* viewControlelr = [[EntryListViewController alloc] initWithEntries:entries];
    [self.navigationController pushViewController:viewControlelr animated:YES];
    [viewControlelr release];
    
}

- (void)logButtonDidPush
{
    LOG_METHOD;
    RCLogViewController* viewController = [[RCLogViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
