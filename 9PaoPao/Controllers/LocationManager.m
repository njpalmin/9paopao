//
//  LocationManager.m
//  Cloudgame
//
//  Created by 黄 洁 on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize locationManager;
@synthesize newLocation = mNewLocation;
@synthesize delegate;

- (void)dealloc {
    
    delegate = nil;
    
	[locationManager stopUpdatingHeading];
    [locationManager release];
	locationManager = nil;
    
	[mNewLocation release];
	mNewLocation = nil;
	
    [super dealloc];
}

- (id)init{
    
    self = [super init];
    if (self) 
	{
        locationManager = [[CLLocationManager alloc] init];
		
        if ([CLLocationManager headingAvailable] == NO) {
            
            [self release];
            self = nil;
        } else {
			
            locationManager.headingFilter = kCLHeadingFilterNone;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            locationManager.delegate = self;
        }
    }
	
    return self;
}

#pragma mark  -
#pragma mark  CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    	
	if (mNewLocation != nil) {
		[mNewLocation release];
        mNewLocation = nil;
	}
	mNewLocation = [newLocation retain];
	
    [delegate locationManagerUpdateHeading:self];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    if ( [error code] == kCLErrorDenied ) {
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}

#pragma mark -
#pragma mark Public

-(void)startUpdate
{
	[locationManager startUpdatingHeading];
}

-(void)stopUpdate
{
	[locationManager stopUpdatingHeading];
}


@end
