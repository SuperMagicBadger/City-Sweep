//
//  HistoryCell.h
//  City Sweep
//
//  Created by John Rice on 7/29/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface HistoryCell : UITableViewCell

@property IBOutlet UILabel* title;
@property IBOutlet UILabel* subtitle;
@property (weak, nonatomic) Data* d;

- (void) setData:(Data*)datum;

@end
