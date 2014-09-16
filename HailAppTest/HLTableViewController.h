//
//  HLTableViewController.h
//  HailAppTest
//
//  Created by Zachary BURGESS on 12/03/2014.
//  Copyright (c) 2014 Zachary BURGESS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView * tableView;

@end
