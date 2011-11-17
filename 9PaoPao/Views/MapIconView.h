//
//  MapIconView.h
//  9PaoPao
//
//  Created by huangjj on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapIconViewDelegate;
#import <MapKit/MapKit.h>

@interface MapIconView : UIView <MKMapViewDelegate>{
    
	id<MapIconViewDelegate>		mDelegate;
    MKMapView                   *locationMapView;
}
@property(nonatomic, assign)id<MapIconViewDelegate>	delegate;
@end

@protocol MapIconViewDelegate <NSObject>

- (void)mapIconViewDisplayDetailMap:(MapIconView *)mapView;

@end