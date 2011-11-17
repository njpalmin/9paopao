//
//  MapViewController.h
//  9PaoPao
//
//  Created by  on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocationService.h"
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapViewController : UIViewController<CoreLocationServiceDelegate,MKMapViewDelegate>
{
    MKMapView *locationMapView;
}

@end
