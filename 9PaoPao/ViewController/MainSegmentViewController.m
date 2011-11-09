    //
//  MainSegmentViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainSegmentViewController.h"
#import "PaoPaoCommon.h"

#define BottomButtonCount		5
#define	BottomButtonOriginY		412

@implementation MainSegmentViewController

@synthesize choosePageIndex = mChoosePageIndex;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	NSAutoreleasePool	*pool = nil;
	UIButton			*button = nil;
	UIView				*container = nil;
	CGRect				bound, buttonFrame;
	float				xOrigin = 0;
    UIImageView         *imageView = nil;
    
	pool = [[NSAutoreleasePool alloc] init];
	
	do {
		
		bound = [[UIScreen mainScreen] bounds];
		
		container = [[[UIView alloc] initWithFrame:bound] autorelease];
		container.backgroundColor = [UIColor whiteColor];
		container.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
        mNavigationController = [[UINavigationController alloc] init];
        mNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
        
        [container addSubview:mNavigationController.view];
		// -----bottom button-----
		
		normalButtonImage = [[NSArray arrayWithObjects:@"home.png", @"live-feed.png", @"my-profile.png", 
									  @"friends.png", @"search.png", nil] retain];
		chooseButtonImage = [[NSArray arrayWithObjects:@"home-selected.png", @"live-feed-selected.png", @"my-profile-selected.png", 
									  @"friend-selected.png", @"search-selected.png", nil] retain];
		
		mButtonArray = [[NSMutableArray alloc] initWithCapacity:BottomButtonCount];
		break_if(mButtonArray == nil);
		
		for (int i = 0; i < BottomButtonCount; i++) {
			button = [[PaoPaoCommon getImageButtonWithName:[normalButtonImage objectAtIndex:i] 
											highlightName:nil 
												   action:@selector(procBottomBtn:) target:self] retain];
			buttonFrame = button.frame;
			buttonFrame.origin = CGPointMake(xOrigin, 1);
			[button setFrame:buttonFrame];
			button.tag = i;
			xOrigin += buttonFrame.size.width;
			[mButtonArray addObject:button];
            
            [button release];
            button = nil;
		}
		
		// -----bottom button-----

        // -----segement---------
        
        mSegementView = [[UIView alloc] init];
        mSegementView.frame = CGRectMake(0, BottomButtonOriginY, bound.size.width, 50);
        
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg.png"]];
        imageView.frame = CGRectMake(0, 0, bound.size.width, 50);
        
        [mSegementView addSubview:imageView];
        
        [imageView release];
        imageView = nil;
        
        xOrigin = 1;
        for (int i = 0; i < [mButtonArray count]; i++) {
            
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-gap.png"]];
            imageView.frame = CGRectMake(xOrigin, 0.5, 1, 50);
			
            [mSegementView addSubview:imageView];
            [mSegementView addSubview:[mButtonArray objectAtIndex:i]];
            
            xOrigin += 64;
            
            [imageView release];
            imageView = nil;
		}
		self.choosePageIndex = 0;
        
        [container addSubview:mSegementView];
        
        
        // -----segement---------
        
		self.view = container;
		[self actionFirstCome];
        
	} while (0);
	
	[pool release];
	pool = nil;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	if (mButtonArray) {
		[mButtonArray release];
		mButtonArray = nil;
	}
	
	if (normalButtonImage) {
		[normalButtonImage release];
		normalButtonImage = nil;
	}
	
	if (chooseButtonImage) {
		[chooseButtonImage release];
		chooseButtonImage = nil;
	}
    //add by mqh begin 2011-11-9
    if (tFVC) {
        [tFVC release];
        tFVC = nil;
    }
    //add by mqh end 2011-11-9
    [super dealloc];
}


#pragma mark -
#pragma mark Action

- (void)procBottomBtn:(id)sender
{
	UIButton *button = (UIButton *)sender;
	
	if ((button.tag >= 0) && (button.tag < BottomButtonCount)) {
		self.choosePageIndex = button.tag;
	}
                    
    switch (button.tag) {
        case 0:
            if (mMainViewController == nil) {
                mMainViewController = [[MainViewController alloc] init];
            }
            [mNavigationController popViewControllerAnimated:NO];
            [mNavigationController pushViewController:mMainViewController animated:NO];
            break;
        case 1:
        {
            //add by mqh begin 2011-11-9
            if (tFVC == nil) {
                NSMutableDictionary *beardDic = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *readWineDic = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *wine2dDic = [[NSMutableDictionary alloc] init];
                NSMutableArray *dicArray = [[NSMutableArray alloc] init];
                NSArray *bear = [[NSArray alloc] initWithObjects:@"啤酒1", @"啤酒2",nil];
                [beardDic setObject:bear forKey:@"啤酒"];
                NSArray *blaceWine = [[NSArray alloc] initWithObjects:@"红酒1", @"红酒2",nil];
                [readWineDic setObject:blaceWine forKey:@"红酒"];
                NSArray *wine2 = [[NSArray alloc] initWithObjects:@"鸡尾酒1", @"鸡尾酒2",nil];
                [wine2dDic setObject:wine2 forKey:@"鸡尾酒"];
                [dicArray addObject:beardDic];
                [dicArray addObject:readWineDic];
                [dicArray addObject:wine2dDic];
                tFVC = [[TellFavoriteViewController alloc] initWithContentDic:dicArray];
                [beardDic release];
                [readWineDic release];
                [wine2 release];
            }
            
            [mNavigationController popViewControllerAnimated:NO];
            [mNavigationController pushViewController:tFVC animated:NO];
           
                        
            //add by mqh end 2011-11-6

            
            break;
        }
        case 2:
            
            break;
        case 3:
            break;
        case 4:
            
            if (mSearchNearbyViewController == nil) {
                mSearchNearbyViewController = [[SearchNearbyViewController alloc] init];
            }
            [mNavigationController popViewControllerAnimated:NO];
            [mNavigationController pushViewController:mSearchNearbyViewController animated:NO];
            break;
        default:
            break;
    }
}

- (void)setChoosePageIndex:(int)index
{
	mChoosePageIndex = index;
	
    UIImage *image = nil;
    
	for (int i = 0; i < [mButtonArray count]; i++) {
		if (i == index) {
			
            image = [UIImage imageNamed:[chooseButtonImage objectAtIndex:i]];
		}else {
            image = [UIImage imageNamed:[normalButtonImage objectAtIndex:i]];
		}
        [[mButtonArray objectAtIndex:i] setBackgroundImage:image forState:UIControlStateNormal];
	}
    
}

#pragma mark -
#pragma mark Private

- (void)actionFirstCome
{
    UIViewController    *rootViewController = nil;
    
    rootViewController = [[[UIViewController alloc] init] autorelease];
    rootViewController.view.backgroundColor = [UIColor whiteColor];
    
    if (mMainViewController == nil) {
        mMainViewController = [[MainViewController alloc] init];
    }
    [mNavigationController pushViewController:rootViewController animated:NO];
    [mNavigationController pushViewController:mMainViewController animated:NO];
}

@end
