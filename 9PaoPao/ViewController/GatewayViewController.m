//
//  GatewayViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GatewayViewController.h"


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
    
    mMostLoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    assert(mMostLoveBtn);
    
    [mMostLoveBtn addTarget:self action:@selector(procMostLoveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mMostLoveBtn setFrame:CGRectMake(100, 50, 150, 30)];
    [mMostLoveBtn setTitle:NSLocalizedString(@"MostLoveDrinkWine", nil) forState:UIControlStateNormal];
    [mMostLoveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mMostLoveBtn setBackgroundColor:[UIColor redColor]];
    
    mSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    assert(mSearchBtn);
    
    [mSearchBtn addTarget:self action:@selector(procSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mSearchBtn setFrame:CGRectMake(100, 150, 100, 30)];
    [mSearchBtn setTitle:NSLocalizedString(@"ImmediatelySearch", nil) forState:UIControlStateNormal];
    [mSearchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mSearchBtn setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:mMostLoveBtn];
    [self.view addSubview:mSearchBtn];
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

- (void)procMostLoveBtn:(id)sender
{
    
}

- (void)procSearchBtn:(id)sender
{
    
}

@end
