//
//  MapViewController.m
//  9PaoPao
//
//  Created by  on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.view = view;
    [view release];
    locationMapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    locationMapView.mapType = MKMapTypeStandard;
    locationMapView.zoomEnabled = YES;
    locationMapView.delegate = self;
    [self.view addSubview:locationMapView];
    if ([[CoreLocationService shareLocationService] locationServiceEnabled]) {
        [[CoreLocationService shareLocationService] startStandardUpdates];
        [CoreLocationService shareLocationService].delegate = self;
    }
	
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
}

- (void)updateLocationMap:(CLLocationCoordinate2D )location
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [locationMapView setRegion:region animated:YES];
    
    //添加注解
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:location];
    //annotation.title = @"我";
    //annotation.coordinate = location;
    [locationMapView addAnnotation:annotation];
    [annotation release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark --------
#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
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

- (void)showDetail:(id)sender
{
    NSLog(@"showDetail");
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
