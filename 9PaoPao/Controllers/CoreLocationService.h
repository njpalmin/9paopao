//
//  CoreLocationService.h
//  9PaoPao
//
//  Created by  on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol CoreLocationServiceDelegate <NSObject>

- (void)updateLocationMap:(CLLocationCoordinate2D )location;

@end

@interface CoreLocationService : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D curLocation;
    id<CoreLocationServiceDelegate> delegate;
}
@property(assign,nonatomic) id<CoreLocationServiceDelegate> delegate;

+(CoreLocationService *)shareLocationService;

- (BOOL)locationServiceEnabled;

- (void)startStandardUpdates;

- (void)stopStandardUpdates;

//regin monitor
- (BOOL)regionMonitorAvailabel;
- (BOOL)regionMonitorEnable;

- (BOOL)registerRegionWithCircularOverlay:(MKCircle*)overlay andIdentifier:(NSString *)identifier;

//heading event
- (void)startHeadingEvent;

@end
