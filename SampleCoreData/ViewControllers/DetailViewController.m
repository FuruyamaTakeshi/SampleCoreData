//
//  DetailViewController.m
//  SampleCoreData
//
//  Created by 古山 健司 on 13/01/14.
//  Copyright (c) 2013年 TF. All rights reserved.
//

#import "DetailViewController.h"
#import "ContentManager.h"
#import "RCDataStatusEntry.h"

#import "RCLogManager.h"

@interface DetailViewController ()
@property (nonatomic, retain) NSMutableArray* dataSource;
@end

@implementation DetailViewController
@synthesize entry = _entry;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithEntry:(id)entry
{
    self = [super init];
    if (self) {
        [entry retain];
        [self.entry release];
        self.entry = entry;
        _dataSource = [[NSMutableArray arrayWithArray:[[ContentManager sharedManager] getsortedStatusesOfAnEntry:self.entry]] retain];
        
        //_dataSource = (NSMutableArray*)[[[ContentManager sharedManager] getsortedStatusesOfAnEntry:self.entry] retain];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = ;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem =  addButton;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[UITableViewCell] alloc] initWithStyle:UITableViewCellStyleDefault resuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell autorelease];
    }
    
    RCDataStatusEntry* status = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = status.title;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)insertNewObject:(id)sender
{
    LOG_METHOD;
    //RCDataStatus* status = [[ContentManager sharedManager] insertNewStatusAtIndex:2];
    RCDataStatus* status = [[ContentManager sharedManager] insertNewStatusToEntry:self.entry];
    status.title = [NSString stringWithFormat:@"state-%@", [RCUtility uuid]];
    status.data = (RCData*)self.entry;
    status.deadLine = [NSDate date];
    status.index = [NSNumber numberWithInteger:[_dataSource count]];
    [_dataSource insertObject:status atIndex:[_dataSource count]];
    
    [[ContentManager sharedManager] save];
    [status release];
    [self.tableView reloadData];
    
}
@end
