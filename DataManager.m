//
//  DataManager.m
//  City Sweep
//
//  Created by John Rice on 7/18/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

- (id) init{
    self = [super init];
    if(self != nil){
        [self readHistory];
        reportQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

//network controls---------------------------
- (BOOL) connect{
    //establish connection
    CFReadStreamRef readRef;
    CFWriteStreamRef writeRef;
    @try{
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@CITYSWEEP_URL, CITYSWEEP_PORT, &readRef, &writeRef);
    
        NSLog(@"nulls? %d, %d", readRef == nil, writeRef == nil);
    
        reader = (NSInputStream *) objc_unretainedObject(readRef);
        writer = (NSOutputStream *) objc_unretainedObject(writeRef);
        [reader open];
        [writer open];
    }
    @catch (NSException* e) {
        NSLog(@"%@", [e reason]);
        self.connected = NO;
        return NO;
    }
    self.connected = YES;
    return YES;
}
- (BOOL) disconnect{
    @try{
        [reader close];
        [writer close];
    }
    @catch (NSException *e) {
        NSLog(@"%@", [e reason]);
        return NO;
    }
    self.connected = NO;
    return YES;
}
- (BOOL) doSend:(Data *)d{
    if(d == nil){
        NSLog(@"data is null");
        return NO;
    }
    if(self.connected){
        NSString *message = [[NSString alloc] initWithFormat:@"%@", [d toString]];
        NSLog(@"sending data: %@", message);
        NSData *data = [[NSData alloc] initWithData:[message dataUsingEncoding:NSASCIIStringEncoding]];
        int dataSent = [writer write:[data bytes] maxLength:[data length]];
        return dataSent != -1;
    }
    return NO;
}
//network controls===========================

//report controls----------------------------
- (void) sendRepport:(Data *)d{
    [reportQueue addObject:d];
    [self pushHistory:d];
    NSLog(@"dm here... got da report: %d", reportQueue.count);
}

- (BOOL) sendNextReport{
    if(self.connected) {
        NSLog(@"conneted");
        if(reportQueue.count > 0){
            Data* d = [reportQueue objectAtIndex:0];
            if(d != nil){
                NSLog(@"sending...");
                if([self doSend:d]){
                    [reportQueue removeObjectAtIndex:0];
                    NSLog(@"data sent");
                    return YES;
                } else {
                    NSLog(@"sending failed...");
                }
            } else {
                NSLog(@"null data");
            }
        } else {
            NSLog(@"no data");
        }
    } else {
        NSLog(@"not connected");
    }
    return NO;
}

- (void) dumpSendQueue{
    NSLog(@"Writing send queue...");
    //prepare file variables
    NSFileManager *man = [NSFileManager defaultManager];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [directory stringByAppendingPathComponent:@"sendQueue.plist"];
    
    //check for existence
    if([man fileExistsAtPath:fileName] == NO){
        NSLog(@"had to create file");
        if([man createFileAtPath:fileName contents:nil attributes:nil] == NO){
            NSLog(@"failed to crete file");
        }
    }
    
    //set up data array
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:historyList.count];
    for(Data* d in reportQueue){
        [array addObject:d.dictionary];
    }
    
    //write array to disk
    [array writeToFile:fileName atomically:true];
}

- (void) readSendQueue{
    NSLog(@"Reading report queue...");
    //file variables
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [directory stringByAppendingPathComponent:@"sendQueue.plist"];
    
    //set up array
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:fileName];
    
    //fill the history
    reportQueue = [[NSMutableArray alloc] initWithCapacity:array.count];
    for(NSMutableDictionary * dict in array){
        [reportQueue addObject:[[Data alloc] initFromDictionary:dict]];
    }
    
}
//report controls============================

//history controls---------------------------
- (void) pushHistory:(Data*)d{
    NSLog(@"pushin histr'y: %i", historyList != nil);
    [historyList addObject:d];
}

- (void) clearHistory{
    [historyList removeAllObjects];
}

- (int) historyCount{
//    return 0;
    return [historyList count];
}

- (Data*) historyItem:(int)index{
    return (Data*) [historyList objectAtIndex:index];
}

- (void) dumpHistory{
    NSLog(@"Writing...");
    //prepare file variables
    NSFileManager *man = [NSFileManager defaultManager];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [directory stringByAppendingPathComponent:@"file.plist"];
    
    //check for existence
    if([man fileExistsAtPath:fileName] == NO){
        NSLog(@"had to create file");
        if([man createFileAtPath:fileName contents:nil attributes:nil] == NO){
            NSLog(@"failed to crete file");
        }
    }
    
    //set up data array
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:historyList.count];
    for(Data* d in historyList){
        [array addObject:d.dictionary];
    }
    
    //write array to disk
    [array writeToFile:fileName atomically:true];
}

- (void) readHistory{
    NSLog(@"Reading...");
    //file variables
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [directory stringByAppendingPathComponent:@"file.plist"];
    
    //set up array
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:fileName];
    
    //fill the history
    historyList = [[NSMutableArray alloc] initWithCapacity:array.count];
    for(NSMutableDictionary * dict in array){
        [historyList addObject:[[Data alloc] initFromDictionary:dict]];
    }
}
//history controls===========================

@end
