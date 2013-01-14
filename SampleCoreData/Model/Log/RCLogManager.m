//
//  RCLogManager.m
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "RCLogManager.h"
#import "RCLog.h"

@implementation RCLogManager
@synthesize checkInTime = _checkInTime;
@synthesize checkOutTime = _checkOutTime;
@synthesize sessionID = _sessionID;

@synthesize managedObjectContext = _managedObjectContext;

static id _instance = nil;
+ (id)log
{
    @synchronized(self) {
        if (!_instance) {
            _instance = [[self alloc] init];
        }
        return _instance;
    }
}

- (NSManagedObjectContext*)managedObjectContext
{
    LOG_METHOD;
    NSError* error;
    
    if(_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSManagedObjectModel* managedModel;
    managedModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator* persistentStoreCoordinator;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedModel];
    [persistentStoreCoordinator autorelease];
    
    NSArray* paths;
    NSString* path = nil;
    
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@"DataBase"];
        path = [path stringByAppendingPathComponent:@"logData.db"];
    }
    if (!path) {
        return nil;
    }
    NSString* dirPath = [path stringByDeletingLastPathComponent];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath]) {
        if (![fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Failed to create directory");
        }
    }
    
    NSURL* url = nil;
    url = [NSURL fileURLWithPath:path];
    
    NSPersistentStore* persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (!persistentStore && error) {
        NSLog(@"Filed to create add persistent store");
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    return _managedObjectContext;
    
}

- (void)logAppStart
{
    self.checkInTime = [NSDate date];
    self.sessionID = [RCUtility uuid];
    
}

- (void)loggAppEnd
{
    self.checkOutTime = [NSDate date];
    
    // Network確認(ReachAbility check)
    
    //転送処理の開始
    
    //成功時送信済に更新する
    NSArray* array = [self getLogs];
    for (RCLog* log in array) {
        //
    }
    
}

- (RCData *)logWithViewController:(UIViewController*)viewController
{
    LOG_METHOD;
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    RCLog* log = [NSEntityDescription insertNewObjectForEntityForName:@"RCLog" inManagedObjectContext:context];
    log.checkInTime = [NSDate date];
    log.sessionID = [[NSDate date] description];
    log.isSent = [NSNumber numberWithBool:NO];
    [self save];
    return log;
}

- (NSArray*)getLogs
{
    LOG_METHOD;
    NSManagedObjectContext* context;
    context = self.managedObjectContext;
    
    NSFetchRequest* request;
    NSEntityDescription* entity;
    NSSortDescriptor* sortDescriptor;
    
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"RCLog" inManagedObjectContext:context];
    [request setEntity:entity];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"RCLog.isSent == %@", [NSNumber numberWithBool:NO]];
//    [request setPredicate:predicate];
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"checkInTime" ascending:YES];
    [sortDescriptor autorelease];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSArray* result;
    NSError* error;
    
    result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Fetch error");
        return nil;
    }
    
    return result;
    
}

- (void)save
{
    LOG_METHOD;
    NSError* error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error, save");
    }
}
@end
