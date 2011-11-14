//
//  LocationManager.h
//  Cloudgame
//
//  Created by 黄 洁 on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define HeadingFilterMinValue   15

@protocol LocationManagerDelegate;

@interface LocationManager : NSObject <CLLocationManagerDelegate>{
    
    id<LocationManagerDelegate> delegate;
    CLLocationManager           *locationManager;
	CLLocation                  *mNewLocation;
}

@property (nonatomic, retain)   CLLocationManager *locationManager;
@property (nonatomic, readonly) CLLocation *newLocation;
@property (nonatomic, assign)   id<LocationManagerDelegate> delegate;

#pragma mark -
#pragma mark Public

-(void)startUpdate;
-(void)stopUpdate;

@end

@protocol LocationManagerDelegate <NSObject>

- (void)locationManagerUpdateHeading:(LocationManager*)controller;
- (void)locationManager:(LocationManager*)controller didReceiveError:(NSError*)error;

@end
