//
//  GatewayViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GatewayViewController.h"
#import "MainSegmentViewController.h"
#import "PaoPaoCommon.h"
#import "AppDelegate.h"

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
    
    if (mNavigationController) {
        [mNavigationController release];
        mNavigationController = nil;
    }
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
    
    UILabel *topText = [[UILabel alloc] initWithFrame:CGRectMake(48, 30, 120, 20)];
    topText.text = NSLocalizedString(@"Now, let's go...",nil);
    [topText sizeToFit];
	topText.font = [UIFont fontWithName:PaoPaoFont size:16.0];
    [self.view addSubview:topText];
    [topText release];
    
    UITextView *midText = [[UITextView alloc] initWithFrame:CGRectMake(30, 74, 240, 70)];
    midText.text = NSLocalizedString(@"Here, in 9paopao, you can find red wine, beer, cocktail, bar and so on which is most suitable for you...but, firstly, let me know what's your favorite!",nil);
    [self.view addSubview:midText];
    midText.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    midText.editable = NO;
    midText.scrollEnabled = NO;
    [midText release];
    
    UILabel *buttomText = [[UILabel alloc] initWithFrame:CGRectMake(44, 220, 220, 20)];
    buttomText.text =NSLocalizedString(@"All I want is that you will search your favorite",nil);
    buttomText.textAlignment = UITextAlignmentLeft;
	buttomText.font = [UIFont fontWithName:PaoPaoFont size:18.0];
    [self.view addSubview:buttomText];
    [buttomText release];
    
    mMostLoveBtn = [[PaoPaoCommon getImageButtonWithName:@"my-favorite.png" highlightName:nil action:@selector(findMostLove:) target:nil] retain];
    assert(mMostLoveBtn);
    
    mMostLoveBtn.frame = CGRectMake(100, 150, mMostLoveBtn.frame.size.width, mMostLoveBtn.frame.size.height);
    
    mSearchBtn = [[PaoPaoCommon getImageButtonWithName:@"search-button.png" highlightName:nil action:@selector(searchMostLove:) target:nil] retain];
    assert(mSearchBtn);
    
    mSearchBtn.frame = CGRectMake(125, 255, mSearchBtn.frame.size.width, mSearchBtn.frame.size.height);
    
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
#pragma mark TellFavoriteViewControllerDelegate

- (void)tellFavoriteViewControllerDidFinish:(TellFavoriteViewController *)controller
{    
    [mNavigationController.view removeFromSuperview];
    [mNavigationController release];
    mNavigationController = nil;
    
    MainSegmentViewController   *mainController = nil;
    id<AppDelegate>             delegate = nil;

    delegate = (id<AppDelegate>)[[UIApplication sharedApplication] delegate];
    mainController = [delegate mainSegmentViewController];

    mainController.view.frame = CGRectMake(0, 0, 320, 460);

    [mainController displayViewControllerWithIndex:0];
    [self presentModalViewController:mainController animated:NO]; 
}

#pragma mark -
#pragma mark Action

- (void)findMostLove:(id)sender
{
    TellFavoriteViewController  *controller = nil;
    
    //bound = [[UIScreen mainScreen] bounds];
    
    // -----init navigationController------
    
    if (mNavigationController == nil) {
        mNavigationController = [[UINavigationController alloc] init];
        mNavigationController.view.frame = CGRectMake(0, 0, 320, 460);
    }
        
    NSMutableDictionary *beardDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableDictionary *readWineDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableDictionary *wine2dDic = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableArray      *dicArray = [[[NSMutableArray alloc] init] autorelease];
    NSArray             *bear = [[[NSArray alloc] initWithObjects:@"啤酒1", @"啤酒2",nil] autorelease];
    NSArray             *blaceWine = [[[NSArray alloc] initWithObjects:@"红酒1", @"红酒2",nil] autorelease];
    NSArray             *wine2 = [[[NSArray alloc] initWithObjects:@"鸡尾酒1", @"鸡尾酒2",nil] autorelease];

    [beardDic setObject:bear forKey:@"啤酒"];
    [readWineDic setObject:blaceWine forKey:@"红酒"];
    [wine2dDic setObject:wine2 forKey:@"鸡尾酒"];
    [dicArray addObject:beardDic];
    [dicArray addObject:readWineDic];
    [dicArray addObject:wine2dDic];
    
    controller = [[TellFavoriteViewController alloc] initWithContentDic:dicArray];
    controller.delegate = self;
    [mNavigationController pushViewController:controller animated:NO];

    [self.view addSubview:mNavigationController.view];
    
    [controller release];
    controller = nil;
}

- (void)searchMostLove:(id)sender
{
    MainSegmentViewController   *controller = nil;
    id<AppDelegate>             delegate = nil;
    
    delegate = (id<AppDelegate>)[[UIApplication sharedApplication] delegate];
    controller = [delegate mainSegmentViewController];
    
    controller.view.frame = CGRectMake(0, 0, 320, 460);
    
	[controller displayViewControllerWithIndex:4];
    [self presentModalViewController:controller animated:YES];  
}

@end
