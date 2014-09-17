//
//  HLTableViewController.m
//  HailAppTest
//
//  Created by Zachary BURGESS on 12/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import "HLTableViewController.h"
#import "HLAppDelegate.h"

static NSString * const HLTableRelaodNotificationName = @"placesHasBeenUpdated";
static NSString * const HLTableViewTitle = @"Restaurant List";
static NSString * const HLCellIdentifiyer = @"Cell";
static NSString * const HLPlaceNameKey = @"name";
static NSString * const HLPlaceVicinityKey = @"vicinity";

static CGFloat const HLTableViewCellHight = 71.0f;

@interface HLTableViewController  ()

@property (assign,nonatomic) HLAppDelegate* delegate;

@end

@implementation HLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:HLTableRelaodNotificationName
                                               object:nil];
    self.title = HLTableViewTitle;
    self.delegate = (HLAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                            target:self
                                                                            action:@selector(refreshRequest)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)refreshRequest
{
    [_delegate.locationManager startUpdatingLocation];
}

-(void)reloadTable
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_delegate.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HLCellIdentifiyer forIndexPath:indexPath];
    NSDictionary* place = [self.delegate.restaurants objectAtIndex:indexPath.row];
    NSString * name = [place objectForKey:HLPlaceNameKey];
    NSString * vicinity = [place objectForKey:HLPlaceVicinityKey];
    [cell.textLabel setText:name];
    [cell.detailTextLabel setText:vicinity];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HLTableViewCellHight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(HLZero, HLZero, self.view.bounds.size.width, HLZero)];
}

@end
