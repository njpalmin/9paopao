//
//  MapIconView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapIconView.h"
#import "MapAnnotation.h"

@implementation MapIconView
 
@synthesize delegate = mDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView	*mapView = nil;
        UIImage		*mapImage = nil;
        
        mapImage = [UIImage imageNamed:@"bar-map-bg.png"];
        mapView = [[[UIImageView alloc] initWithImage:mapImage] autorelease];
        mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        locationMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        locationMapView.mapType = MKMapTypeStandard;
        locationMapView.zoomEnabled = YES;
        locationMapView.delegate = self;

        [self addSubview:mapView];
        [self addSubview:locationMapView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Respons
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mDelegate mapIconViewDisplayDetailMap:self];
}
*/
- (void)dealloc
{
    [locationMapView release];
    locationMapView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MapAnnotation class]] == YES) {
        MKPinAnnotationView *view;
        view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (view == nil) {
            view = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"] autorelease];
            view.pinColor = MKPinAnnotationColorRed;
            view.animatesDrop = YES;
            view.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
            view.rightCalloutAccessoryView = rightButton;
        }else
        {
            view.annotation = annotation;
        }
        
        return view;
    }else
    {
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"didSelectAnnotationView");
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view  calloutAccessoryControlTapped:(UIControl *) control  
{
    NSLog(@"annotationView");
}  

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated  
{  
    NSLog(@"regionDidChangeAnimated");  
    
} 

@end
