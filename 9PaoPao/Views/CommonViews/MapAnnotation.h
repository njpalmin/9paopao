//
//  MapAnnotation.h
//  9PaoPao
//
//  Created by  on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;


}

@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;


- (id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end

