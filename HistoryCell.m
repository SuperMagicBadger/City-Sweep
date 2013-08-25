//
//  HistoryCell.m
//  City Sweep
//
//  Created by John Rice on 7/29/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setData:(Data *)datum{
    self.d = datum;
    self.title.text = [datum getReportTitle];
    self.subtitle.text = [[NSString alloc] initWithFormat:@"%@  %@  %@",
                                                           [self.d getReportDate],
                                                           [self.d getReportLongitude],
                                                           [self.d getReportLatitude]
                          ];
}

@end
