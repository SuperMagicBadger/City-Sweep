//
//  Reporter.m
//  City Sweep
//
//  Created by John Rice on 7/16/13.
//  Copyright (c) 2013 John Rice. All rights reserved.
//

#import "Reporter.h"

@implementation Reporter

- (void)viewDidLoad
{
    [super viewDidLoad];

    locationManager = [[CLLocationManager alloc] init];
    
    self.celllist = [[NSMutableArray alloc] init];
    [self.celllist addObject:(@"Graffiti")];
    [self.celllist addObject:(@"Vandalism")];
    [self.celllist addObject:(@"Road Hazard")];
    [self.celllist addObject:(@"Somethings Broken")];
    [self.celllist addObject:(@"Noise Disturbance")];
    [self.celllist addObject:(@"Gunshotst")];
    [self.celllist addObject:(@"Filler Stuff")];
    
    alertView = [
                 [UIAlertView alloc]
                 initWithTitle:@"title"
                 message:@"mesage"
                 delegate:self
                 cancelButtonTitle:@"cancel"
                 otherButtonTitles:@"OK", nil
                 ];
    alertView.opaque = YES;
    
    
    AppDelegate* app = (AppDelegate*) [UIApplication sharedApplication].delegate;
    self.dm = app.datamanager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.celllist count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //acquire cell
    NSString *CellIdentifier;
    if(indexPath.item < [self.celllist count]){
        CellIdentifier = @"reportItem";
    } else {
        CellIdentifier = @"customItem";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //set cell
    if(indexPath.item < [self.celllist count]){
        cell.textLabel.text = [self.celllist objectAtIndex:(indexPath.item)];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set the report type
    if(indexPath.item < [self.celllist count]){
        NSLog(@"%@", [self.celllist objectAtIndex:indexPath.item]);
        [self displayAlertBoxWithReport:[self.celllist objectAtIndex:indexPath.item]];
    }
}

#pragma mark - Textbox delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self displayAlertBoxWithReport:[textField text]];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Alert view delegate
- (void) displayAlertBoxWithReport:(NSString*)reportType{
    //set the title and message
    alertView.title = reportType;
    alertView.message = [[NSString alloc] initWithFormat:@"report a %@", reportType];
    
    //show it
    [alertView show];
    
    //init the data
    d = [[Data alloc] init];
    [d setReportTypeTo:alertView.title];
    [d setReportDateTo:[NSDate date]];
    
    //set the location data
    CLLocation *location;
    if(CLLocationManager.locationServicesEnabled){
        location = [locationManager location];
    } else {
        location = [[CLLocation alloc] initWithLatitude:200 longitude:200];
    }
    NSLog(@"%f, %f", location.coordinate.longitude, location.coordinate.latitude);
    [d setReportLatitudeTo:location.coordinate.latitude];
    [d setReportLongitudeTo:location.coordinate.longitude];
    NSLog(@"reporting time: %i", self.dm != nil);
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch(buttonIndex){
        case 0:
            d = nil;
            break;
        case 1:
            [self.dm sendRepport:d];
            break;
        default:
            NSLog(@"button id: %i", buttonIndex);
            break;
    }
    [self.viewTable deselectRowAtIndexPath:[self.viewTable indexPathForSelectedRow] animated:YES];
}
@end
