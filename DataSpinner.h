//
//  DataSpinner.h
//  City Sweep
//
//  Created by John Rice on 8/27/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

@interface DataSpinner : NSOperation{
    BOOL executing;
    BOOL finished;
}

@property DataManager* dman;
- (id) initWithData:(id)data;

@end
