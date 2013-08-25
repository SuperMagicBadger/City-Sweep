//
//  Data.m
//  City Sweep
//
//  Created by John Rice on 7/17/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "Data.h"

@implementation Data

static NSKeyedArchiver* archiver = nil;

//initialize--------------------------------------------
- (id) init{
    self = [super init];
    if(self != nil){
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id) initFromDictionary:(NSMutableDictionary *)dict{
    self = [super init];
    if(self != nil){
        _dictionary = dict;
    }
    return self;
}

//raw token managment-----------------------------------
- (void) pushToken:(NSString *)key withValue:(id)value{
    [_dictionary setObject:value forKey:key];
}
- (id) valueAt:(NSString *)key{
    return [_dictionary objectForKey:key];
}

//fixed token manips------------------------------------
- (void) setReportTypeTo:(NSString *)type{
    [self pushToken:(@KEY_TYPE) withValue:(type)];
}
- (void) setReportDateTo:(NSDate *)date{
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm:ss MM/dd/yyyy"];
    NSString* datestring = [dateFormater stringFromDate:date];
    [self pushToken:(@KEY_DATE) withValue:(datestring)];
}
- (void) setReportLongitudeTo:(double)longitude{
    [self pushToken:(@KEY_LONGITUDE) withValue:[[NSNumber alloc] initWithDouble:longitude]];
}
- (void) setReportLatitudeTo:(double)latitude{
    [self pushToken:(@KEY_LATITUDE) withValue:[[NSNumber alloc] initWithDouble:latitude]];
}

//fixed token access-------------------------------------
- (NSString*) getReportTitle{
    return [self valueAt:@KEY_TYPE];
}
- (NSString*) getReportDate{
    return [self valueAt:@KEY_DATE];
}
- (NSNumber*) getReportLongitude{
    return [self valueAt:@KEY_LONGITUDE];
}
- (NSNumber*) getReportLatitude{
    return [self valueAt:@KEY_LATITUDE];
}

//string generation---------------------------------------
- (NSString*) toString{
    NSMutableString* returnitem = [[NSMutableString alloc] initWithCapacity:_dictionary.count];
    
    for(NSString* s in _dictionary){
        [returnitem appendFormat:(@"%@ = %@ "), s, [_dictionary objectForKey:s]];
    }
    
    [returnitem appendString:(@"\n")];
    
    return returnitem;
}


@end
