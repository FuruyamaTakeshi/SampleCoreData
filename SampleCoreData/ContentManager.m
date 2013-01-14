//
//  ContentManager.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/12.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ContentManager.h"
#import "RCUtility.h"
#import "Content.h"
#import "RCEntry.h"
#import "RCData.h"
#import "RCDataFormat.h"
#import "RCDataFormatFactory.h"
#import "RCDataFormatJSON.h"
#import "RCDataStatus.h"
#import "RCDataStatusEntry.h"

@implementation ContentManager
@synthesize contents = _contents;

static id _instance = nil;
+ (id)sharedManager
{
    LOG_METHOD;
    @synchronized(self)
    {
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}


- (NSManagedObjectContext*)managedObjectContext
{
    LOG_METHOD;
    NSError*    error;
    
    // インスタンス変数のチェック
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    // 管理対象オブジェクトモデルの作成
    NSManagedObjectModel*   managedObjectModel;
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 永続ストアコーディネータの作成
    NSPersistentStoreCoordinator*   persistentStoreCoordinator;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:managedObjectModel];
    [persistentStoreCoordinator autorelease];
    
    // 保存ファイルの決定
    NSArray*    paths;
    NSString*   path = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@"DataBase"];
        path = [path stringByAppendingPathComponent:@"furuyama.db"];
    }
    
    if (!path) {
        return nil;
    }
    
    // ディレクトリの作成
    NSString*       dirPath;
    NSFileManager*  fileMgr;
    dirPath = [path stringByDeletingLastPathComponent];
    fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        if (![fileMgr createDirectoryAtPath:dirPath
                withIntermediateDirectories:YES attributes:nil error:&error])
        {
            NSLog(@"Failed to create directory at path %@, erro %@",
                  dirPath, [error localizedDescription]);
        }
    }
    
    // ストアURLの作成
    NSURL*  url = nil;
    url = [NSURL fileURLWithPath:path];
    
    // 永続ストアの追加
    NSPersistentStore*  persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                               configuration:nil URL:url options:nil error:&error];
    if (!persistentStore && error) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    // 管理対象オブジェクトコンテキストの作成
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    
    // 永続ストアコーディネータの設定
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return _managedObjectContext;
}
- (RCEntry*)insertNewEntry
{
    NSManagedObjectContext *context;
    context = self.managedObjectContext;
    
    RCEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"RCEntry" inManagedObjectContext:context];
    entry.identifier = [RCUtility uuid];
    return entry;
}

- (RCDataStatus*)insertNewStatusAtIndex:(int)index
{
    LOG_METHOD;
    
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RCEntry" inManagedObjectContext:context]];
    
    NSError* error = nil;
    NSArray* entries = [context executeFetchRequest:request error:&error];
    [request release];
    
    RCDataStatus* status = [NSEntityDescription insertNewObjectForEntityForName:@"RCDataStatusEntry" inManagedObjectContext:context];
    
    RCData* entry = [entries objectAtIndex:index];
    [entry addContentsObject:status];
    
    return status;
}
- (RCDataStatus*)insertNewStatusToEntry:(id)anEntry
{
    LOG_METHOD;
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"RCEntry" inManagedObjectContext:context]];
    
    NSError* error = nil;
    NSArray* entries = [context executeFetchRequest:request error:&error];
    NSUInteger index = [entries indexOfObject:anEntry];
    RCData* entry = [entries objectAtIndex:index];
    RCDataStatus* status = [NSEntityDescription insertNewObjectForEntityForName:@"RCDataStatusEntry" inManagedObjectContext:context];
    [entry addContentsObject:status];
    
    return status;
    
}
- (NSArray*)getsortedStatusAtIndex:(int)index
{
    LOG_METHOD;
//    NSManagedObjectContext* context;
//    context = self.managedObjectContext;
//    
//    NSFetchRequest* request;
//    
//    request = [[NSFetchRequest alloc] init];
//    [request setEntity:[NSEntityDescription entityForName:@"RCData" inManagedObjectContext:context]];
//    
//    NSError* error = nil;
//    NSArray* entries = [context executeFetchRequest:request error:&error];
//    [request release];
    
    NSArray* entries = [self getEntitiesWithName:@"RCData"];
    
    RCData* ent = [entries objectAtIndex:index];
    NSMutableArray *sortedStatuses = [[NSMutableArray alloc] initWithArray:[ent.contents allObjects]];
	
    return sortedStatuses;
}

- (NSArray*)getsortedStatusesOfAnEntry:(id)entry
{
    LOG_METHOD;
    NSArray* entries = [self getEntitiesWithName:@"RCData"];
    
    if ([entries containsObject:entry]) {
        RCData* ent = [entries objectAtIndex:[entries indexOfObject:entry]];
        NSMutableArray *sortedStatuses = [[NSMutableArray alloc] initWithArray:[ent.contents allObjects]];
        return sortedStatuses;
    }
    else {
        return nil;
    }
}

- (NSArray*)getEntitiesWithName:(NSString*)aName
{
    LOG_METHOD;
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    NSFetchRequest* request;
    request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:aName inManagedObjectContext:context]];
    
    NSError* error = nil;
    NSArray* entries = [context executeFetchRequest:request error:&error];
    [request release];

    return entries;
}

- (NSArray*)getsortedStatus
{
    LOG_METHOD;
    NSManagedObjectContext *context;
    context = self.managedObjectContext;
    
    NSFetchRequest *request;
    NSEntityDescription* entity;
    NSSortDescriptor* sortDescriptor;
    
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"RCDataStatus" inManagedObjectContext:context];
    [request setEntity:entity];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
    [sortDescriptor autorelease];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSArray *result;
    NSError *error;
    
    result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error   ");
        return nil;
    }
    
    return result;
//    return [self getsortedItem:@"RCDataStatusEntry"];
}
- (NSArray*)getsortedEntry
{
    LOG_METHOD;
    return [self getsortedItem:@"RCEntry"];
}

- (NSArray*)getsortedItem:(NSString*)name
{
    LOG_METHOD;
    NSManagedObjectContext *context;
    context = self.managedObjectContext;
    
    NSFetchRequest *request;
    NSEntityDescription* entity;
    NSSortDescriptor* sortDescriptor;
    
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:name inManagedObjectContext:context];
    [request setEntity:entity];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [sortDescriptor autorelease];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSArray *result;
    NSError *error;
    
    result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error");
        return nil;
    }
    return result;
}

- (void)save
{
    LOG_METHOD;
    NSError* error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error, %@", error);
    }
}

- (void)check
{
    LOG_METHOD;
    RCDataFormat *jsonFormat = [RCDataFormatFactory factoryWithName:@"JSON"];
    NSDictionary* dicTaro = [NSDictionary dictionaryWithObjectsAndKeys:@"Taro",@"name", @"24", @"age", @"Tokyo", @"livingarea", @"teacher", @"shokugyo", nil];
    NSDictionary* dicJiro = [NSDictionary dictionaryWithObjectsAndKeys:@"Jiro",@"name", @"22", @"age", @"Chiba", @"livingarea", @"student", @"shokugyo", nil];
    jsonFormat.content = [NSArray arrayWithObjects:dicTaro, dicJiro, nil];
    NSData *data = [jsonFormat createFormatData];
    NSString *myString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", myString);
}
@end
