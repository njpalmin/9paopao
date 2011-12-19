//
//  LatestOfferController.m
//  9PaoPao
//
//  Created by  on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LatestOfferController.h"
#import "PaoPaoCommon.h"

@implementation LatestOfferController

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

- (void)dealloc
{
    [allLatestOfferBtn release];
    [currentLatestOfferBtn release];
    [currentLatestOfferVC release];
    [allLatestOfferVC release];
    [super dealloc];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:searchBar];
    
    currentLatestOfferBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 45, 109, 30)];
    [currentLatestOfferBtn setBackgroundImage:[UIImage imageNamed:@"current-offer-selected.png"] forState:UIControlStateNormal];
    [currentLatestOfferBtn addTarget:self action:@selector(currentLatestOffer:) forControlEvents:UIControlEventTouchUpInside];
    //[currentLatestOfferBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [self.view addSubview:currentLatestOfferBtn];
    allLatestOfferBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 45, 109, 30)];
    [allLatestOfferBtn setBackgroundImage:[UIImage imageNamed:@"all-offers-selected.png"] forState:UIControlStateSelected];
    [allLatestOfferBtn setBackgroundImage:[UIImage imageNamed:@"all-offers.png"] forState:UIControlStateNormal];
    [allLatestOfferBtn setSelected:YES];
    [allLatestOfferBtn addTarget:self action:@selector(allLatestOffer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allLatestOfferBtn];
    LatestOfferObject *object = [[LatestOfferObject alloc] init];
    object.latestOfferTitle = @"红酒大促销";
    object.latestOfferHost = @"波尔多";
    object.latestOfferLocation = @"波尔多";
    object.latestOfferComment = @"促销时间2011／9／25";
    NSArray *array = [[NSArray alloc] initWithObjects:object,object,object,object,object, nil];
    allLatestOfferVC = [[LatestOfferViewController alloc] initControllerWithArray:array];
    [self.view addSubview:allLatestOfferVC.view];
    allLatestOfferVC.view.frame = CGRectMake(0, 80, 320, 296);
    [array release];
    [object release];
    object = nil;

    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:@"" action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;    
    self.navigationItem.title = NSLocalizedString(@"latestOffer Page Title", nil);
    
    [leftItem release];
    leftItem = nil;
}

- (void)allLatestOffer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        return;
    }else
    {
         [self.view addSubview:allLatestOfferVC.view];
        [btn setSelected:YES];
        [currentLatestOfferBtn setSelected:NO];
    }
}

- (void)currentLatestOffer:(id)sender
{
    if (currentLatestOfferBtn.selected) {
        return;
    }else
    {
        [allLatestOfferVC.view removeFromSuperview];
        [currentLatestOfferBtn setSelected:YES];
        [allLatestOfferBtn setSelected:NO];
    }
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

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
