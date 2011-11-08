//
//  SearchNearbyViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchNearbyViewController.h"
#import "PaoPaoCommon.h"

@implementation SearchNearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    do{
        break_if(![self prepareNavigationBar]);
        
    }while (0);
}                                                                                      
                                                                                                                       
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

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *rightItem = nil;
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    UIButton            *rightButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procReturn:) target:self];
    rightButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procChooseRange:) target:self];
    
    //leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(procReturn:)];
    rightItem = [[UIBarButtonItem alloc] initWithTitle:@"2公里" style:UIBarButtonItemStylePlain target:self action:@selector(procChooseRange:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
    
    [leftItem release];
    leftItem = nil;
    
    [rightItem release];
    rightItem = nil;
    
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    
}

- (void)procChooseRange:(id)sender
{
    
}                             

@end
