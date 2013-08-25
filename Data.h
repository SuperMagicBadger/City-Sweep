//
//  Data.h
//  City Sweep
//
//  Created by John Rice on 7/17/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_TYPE "type"
#define KEY_DATE "time"
#define KEY_USER "username"
#define KEY_USEREPOCH "userepoch"
#define KEY_LONGITUDE "longitude"
#define KEY_LATITUDE "latitude"
#define KEY_KEYORDER "keyorder"

@interface Data : NSObject{
}

@property NSMutableDictionary *dictionary;


- (id) init;
- (id) initFromDictionary:(NSMutableDictionary*) dict;

- (void) pushToken:(NSString*)key withValue:(id)value;
- (id) valueAt:(NSString*)key;

- (void) setReportTypeTo:(NSString*)type;
- (void) setReportDateTo:(NSDate*)date;
- (void) setReportLongitudeTo:(double)longitude;
- (void) setReportLatitudeTo:(double)latitude;

- (NSString*) getReportTitle;
- (NSString*) getReportDate;
- (NSNumber*) getReportLongitude;
- (NSNumber*) getReportLatitude;

- (NSString*) toString;

@end
