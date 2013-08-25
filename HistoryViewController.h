//
//  HistoryViewController.h
//  City Sweep
//
//  Created by John Rice on 7/27/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataManager.h"
#import "Data.h"
#import "HistoryCell.h"

@interface HistoryViewController : UITableViewController

@property (weak, nonatomic) DataManager *dm;

@end
