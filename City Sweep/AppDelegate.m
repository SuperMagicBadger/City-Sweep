//
//  AppDelegate.m
//  City Sweep
//
//  Created by John Rice on 7/15/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate {
    DataSpinner *spinner;
    NSOperationQueue *opQueue;
}

-(id) init {
    self = [super init];
    if(self){
        self.datamanager = [[DataManager alloc] init];
        opQueue = [NSOperationQueue new];
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.datamanager connect];
    spinner = [[DataSpinner alloc] initWithData:self.datamanager];[opQueue addOperation:spinner];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.datamanager dumpHistory];
    [self.datamanager dumpSendQueue];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.datamanager readHistory];
    [self.datamanager readSendQueue];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
