//
//  CoreLocationService.m
//  9PaoPao
//
//  Created by  on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CoreLocationService.h"

static CoreLocationService *singleInstance = nil;
@implementation CoreLocationService
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 10.0f;
    }
    return self;
}

- (BOOL)locationServiceEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

- (void)startStandardUpdates
{
    [locationManager startUpdatingLocation];
}

- (void)stopStandardUpdates
{
    [locationManager stopUpdatingLocation];
}

+ (CoreLocationService *)shareLocationService
{
    if (singleInstance == nil) {
        singleInstance = [[CoreLocationService alloc] init];
    }
    return singleInstance;
}

- (void)dealloc
{
    [locationManager release];
    locationManager = nil;
    [super dealloc];
}

//regin monitor
- (BOOL)regionMonitorAvailabel
{
    return [CLLocationManager regionMonitoringAvailable];
}

- (BOOL)regionMonitorEnable
{
    return [CLLocationManager regionMonitoringEnabled];
}

- (BOOL)registerRegionWithCircularOverlay:(MKCircle *)overlay andIdentifier:(NSString *)identifier
{
    if (![self regionMonitorAvailabel] ||
        ![self regionMonitorEnable]) {
        return NO;
    }
    CLLocationDegrees radius = overlay.radius;
    if (radius > locationManager.maximumRegionMonitoringDistance) {
        radius = locationManager.maximumRegionMonitoringDistance;
    }
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:overlay.coordinate radius:radius identifier:identifier];
        [locationManager startMonitoringForRegion:region desiredAccuracy:kCLLocationAccuracyHundredMeters];
        [region release];
        return YES;
    
}

#pragma mark -------
#pragma mark heading event
- (void)startHeadingEvent
{
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
        [locationManager startUpdatingHeading];
    }
}

#pragma mark ----------
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        NSLog(@"latitude %.6f,longitude %.6f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        curLocation = newLocation.coordinate;
        [delegate updateLocationMap:curLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

//region monitor
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"register region error");
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"enter region");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"exit region");
}

//heading event
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0) {
        return;
    }
    //CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
}



@end
