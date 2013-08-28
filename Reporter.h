//
//  Reporter.h
//  City Sweep
//
//  Created by John Rice on 7/16/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import "AppDelegate.h"
#import "DataManager.h"
#import "Data.h"

@interface Reporter : UIViewController <UITableViewDataSource, UITextFieldDelegate>{
    CLLocationManager *locationManager;
    UIAlertView *alertView;
    Data* d;
}

@property NSMutableArray *celllist;
@property IBOutlet UITableView *viewTable;
@property (weak, atomic) DataManager *dm;

@end
