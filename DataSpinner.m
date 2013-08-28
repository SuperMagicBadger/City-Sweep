//
//  DataSpinner.m
//  City Sweep
//
//  Created by John Rice on 8/27/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "DataSpinner.h"

@implementation DataSpinner

- (id) initWithData:(id)data{
    self = [super init];
    if(self != nil){
        self.dman = data;
        executing = false;
        finished = false;
    }
    return self;
}

- (void) main{
    while(!self.isCancelled){
//        NSLog(@"spin!");
        [self.dman sendNextReport];
    }
}

@end
