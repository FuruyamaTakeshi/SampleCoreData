//
//  ContentManager.m
//  SampleCoreData
//
//  Created by 古山 健司 on 12/12/12.
//  Copyright (c) 2012年 TF. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "ContentManager.h"
#import "Content.h"
#import "RCEntry.h"
#import "RCData.h"
#import "RCDataFormat.h"
#import "RCDataFormatFactory.h"
#import "RCDataFormatJSON.h"

@implementation ContentManager
@synthesize contents = _contents;
static id _instance = nil;

+ (id)sharedInstance
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

- (Content*)insertContent
{
    LOG_METHOD;
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    Content *content = [NSEntityDescription insertNewObjectForEntityForName:@"RCDataStatus" inManagedObjectContext:context];
    
    CFUUIDRef uuid;
    NSString *identifier;
    uuid = CFUUIDCreate(NULL);
    identifier = (NSString*)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    [identifier autorelease];
    //content.identifier = identifier;
    
    return content;
}

- (NSArray*)getsortedStatus
{
    LOG_METHOD;
//    NSManagedObjectContext *context;
//    context = self.managedObjectContext;
//    
//    NSFetchRequest *request;
//    NSEntityDescription* entity;
//    NSSortDescriptor* sortDescriptor;
//    
//    request = [[NSFetchRequest alloc] init];
//    entity = [NSEntityDescription entityForName:@"RCDataStatus" inManagedObjectContext:context];
//    [request setEntity:entity];
//    
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
//    [sortDescriptor autorelease];
//    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
//    
//    NSArray *result;
//    NSError *error;
//    
//    result = [context executeFetchRequest:request error:&error];
//    if (!result) {
//        NSLog(@"Error   ");
//        return nil;
//    }
//    
//    return result;
    return [self getsortedItem:@"RCDataStatus"];
}
- (NSArray*)getsortedEntry
{
    return [self getsortedItem:@"RCDataStatusEntry"];
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
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
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
}
- (RCEntry*)insertNewEntry
{
    NSManagedObjectContext *context;
    context = self.managedObjectContext;
    
    RCEntry *entry;
    entry = [NSEntityDescription insertNewObjectForEntityForName:@"RCEntry" inManagedObjectContext:context];
    
    CFUUIDRef uuid;
    NSString *identifier;
    uuid = CFUUIDCreate(NULL);
    identifier = (NSString*)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    [identifier autorelease];
    entry.identifier = identifier;
    
    return entry;
    
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
    RCDataFormat *jsonFormat = [RCDataFormatFactory factoryWithName:@"JSON"];
    NSDictionary* dicTaro = [NSDictionary dictionaryWithObjectsAndKeys:@"Taro",@"name", @"24", @"age", @"Tokyo", @"livingarea", @"teacher", @"shokugyo", nil];
    NSDictionary* dicJiro = [NSDictionary dictionaryWithObjectsAndKeys:@"Jiro",@"name", @"22", @"age", @"Chiba", @"livingarea", @"student", @"shokugyo", nil];
    jsonFormat.content = [NSArray arrayWithObjects:dicTaro, dicJiro, nil];
    NSData *data = [jsonFormat createFormatData];
    NSString *myString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"%@", myString);
}
@end
