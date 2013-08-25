//
//  DataManager.h
//  City Sweep
//
//  Created by John Rice on 7/18/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

#define CITYSWEEP_URL "citysweep.deltacitylabs.com"
#define CITYSWEEP_PORT 12241

@interface DataManager : NSObject {
    //networking shits
    NSInputStream *reader;
    NSOutputStream *writer;
    NSThread *thread;
    
    //something about asynchronous sending
    NSMutableArray *workQueue;

    //history storage
    NSMutableArray *historyList;
}

- (id) init;
+ (DataManager*) sharedManager;

//network controls
@property BOOL connected;
- (BOOL) connect;
- (BOOL) disconnect;
- (void) doSend:(Data*)d;

//spin controls
//- (void) startSpin;
//- (void) suspendSpin;
//- (void) stopSpin;
//- (void) spin;

//report controls
- (void) sendRepport:(Data*) d;
- (void) clearQueue;

//history controlls
- (void) pushHistory:(Data*) d;
- (void) clearHistory;
- (int) historyCount;
- (Data*) historyItem:(int)index;
- (void) dumpHistory;
- (void) readHistory;
@end

