//
//  HLTableViewController.h
//  HailAppTest
//
//  Created by Zachary BURGESS on 12/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

/** Hail Test App Table View Controller*/
@interface HLTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

/** @name tableView  the view's table view*/
@property (strong,nonatomic) IBOutlet UITableView * tableView;

@end
