//
//  GatewayViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GatewayViewController.h"
#import "MainSegmentViewController.h"

@implementation GatewayViewController

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
    [mMostLoveBtn release];
    [mSearchBtn release];
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

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *topText = [[UILabel alloc] initWithFrame:CGRectMake(44, 30, 120, 20)];
    topText.text = NSLocalizedString(@"Now, let's go...",nil);
    [topText sizeToFit];
    [self.view addSubview:topText];
    [topText release];
    
    UITextView *midText = [[UITextView alloc] initWithFrame:CGRectMake(38, 74, 220, 70)];
    midText.text = NSLocalizedString(@"Here, in 9paopao, you can find red wine, beer, cocktail, bar and so on which is most suitable for you...but, firstly, let me know what's your favorite!",nil);
    [self.view addSubview:midText];
    midText.font = [UIFont systemFontOfSize:14.0];
    midText.editable = NO;
    midText.scrollEnabled = NO;
    [midText release];
    
    UILabel *buttomText = [[UILabel alloc] initWithFrame:CGRectMake(44, 220, 220, 20)];
    buttomText.text =NSLocalizedString(@"All I want is that you will search your favorite",nil);
    [buttomText sizeToFit];
    [self.view addSubview:buttomText];
    [buttomText release];
    
    mMostLoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    assert(mMostLoveBtn);
    
    [mMostLoveBtn addTarget:self action:@selector(findMostLove:) forControlEvents:UIControlEventTouchUpInside];
    [mMostLoveBtn setFrame:CGRectMake(90, 170, 128, 28)];
    [mMostLoveBtn setTitle:NSLocalizedString(@"MostLoveDrinkWine", nil) forState:UIControlStateNormal];
    [mMostLoveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mMostLoveBtn setBackgroundColor:[UIColor redColor]];
    
    mSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    assert(mSearchBtn);
    
    [mSearchBtn addTarget:self action:@selector(searchMostLove:) forControlEvents:UIControlEventTouchUpInside];
    [mSearchBtn setFrame:CGRectMake(112, 268, 90, 28)];
    [mSearchBtn setTitle:NSLocalizedString(@"ImmediatelySearch", nil) forState:UIControlStateNormal];
    [mSearchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mSearchBtn setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:mMostLoveBtn];
    [self.view addSubview:mSearchBtn];
    
    mNavigationController = [[UINavigationController alloc] init];
    mNavigationController.view.frame = CGRectMake(0, 0, 320, 460);
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
#pragma mark Action

- (void)findMostLove:(id)sender
{
    
}

- (void)searchMostLove:(id)sender
{
    MainSegmentViewController  *searchNearbyViewController = nil;
    
    searchNearbyViewController = [[MainSegmentViewController alloc] init];
    [mNavigationController pushViewController:searchNearbyViewController animated:NO];
    
    [self presentModalViewController:mNavigationController animated:YES];
}

@end
