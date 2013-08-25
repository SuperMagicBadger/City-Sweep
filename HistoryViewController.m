//
//  HistoryViewController.m
//  City Sweep
//
//  Created by John Rice on 7/27/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "HistoryViewController.h"


@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* app = (AppDelegate*) [UIApplication sharedApplication].delegate;
    self.dm = app.datamanager;
}

- (void) viewDidAppear:(BOOL)animated{
    [(UITableView*)(self.view) reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that, can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dm historyCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryCell* cell = (HistoryCell*) [tableView dequeueReusableCellWithIdentifier:@"historyItem"];
    Data* m = [self.dm historyItem:indexPath.item];
    [cell setData:m];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
