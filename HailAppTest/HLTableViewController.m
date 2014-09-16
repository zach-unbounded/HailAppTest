//
//  HLTableViewController.m
//  HailAppTest
//
//  Created by Zachary BURGESS on 12/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import "HLTableViewController.h"
#import "HLAppDelegate.h"

@interface HLTableViewController  ()

@property (weak,nonatomic) HLAppDelegate* delegate;

@end

@implementation HLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"placesHasBeenUpdated" object:nil];
    self.title = @"Restaurant List";
    _delegate = [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshRequest)];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_delegate.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary* place = [_delegate.restaurants objectAtIndex:indexPath.row];
    
    NSString * name = [place objectForKey:@"name"];
    
    NSString * vicinity = [place objectForKey:@"vicinity"];
    
    [cell.textLabel setText:name];
    [cell.detailTextLabel setText:vicinity];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
}

@end
