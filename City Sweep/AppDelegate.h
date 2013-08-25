//
//  AppDelegate.h
//  City Sweep
//
//  Created by John Rice on 7/15/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataManager *datamanager;

@end
