    //
//  MainSegmentViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainSegmentViewController.h"
#import "PaoPaoCommon.h"

#define BottomButtonCount			5
#define	BottomButtonOriginY			412

#define HomeViewControllerTag		101
#define LiveViewControllerTag		102
#define ProfileViewControllerTag	103
#define FriendViewControllerTag		104
#define SearchViewControllerTag		105

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
		
		// -----init navigationController------
        mHomeNavigationController = [[UINavigationController alloc] init];
        mHomeNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
		mHomeNavigationController.view.tag = 100;
		
		mLiveNavigationController = [[UINavigationController alloc] init];
        mLiveNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
		mLiveNavigationController.view.tag = 101;
		
		mProfileNavigationController = [[UINavigationController alloc] init];
        mProfileNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
		mProfileNavigationController.view.tag = 102;
		
		mFriendNavigationController = [[UINavigationController alloc] init];
        mFriendNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
		mFriendNavigationController.view.tag = 103;
		
		mSearchNavigationController = [[UINavigationController alloc] init];
        mSearchNavigationController.view.frame = CGRectMake(0, 0, bound.size.width, PageWithoutSegementHeight);
        mSearchNavigationController.view.tag = 104;
        
		// ------init navigationController------
		
		// -----bottom button-----
		
		normalButtonImage = [[NSArray arrayWithObjects:@"tab-home.png", @"tab-live-feed.png", @"tab-my-profile.png", 
									  @"tab-friend.png", @"tab-search.png", nil] retain];
		chooseButtonImage = [[NSArray arrayWithObjects:@"tab-home-selected.png", @"tab-live-feed-selected.png", @"tab-my-profile-selected.png", @"tab-friend-selected.png", @"tab-search-selected.png", nil] retain];
		
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
            imageView.frame = CGRectMake(xOrigin, 0.5, 2, 48);
			
            [mSegementView addSubview:imageView];
            [mSegementView addSubview:[mButtonArray objectAtIndex:i]];
            
            xOrigin += 64;
            
            [imageView release];
            imageView = nil;
		}
		self.choosePageIndex = -1;
        
        [container addSubview:mSegementView];
        
        
        // -----segement---------
        
		self.view = container;
        
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

	if (mHomeNavigationController) {
		[mHomeNavigationController release];
		mHomeNavigationController = nil;
	}
	
	if (mLiveNavigationController) {
		[mLiveNavigationController release];
		mLiveNavigationController = nil;
	}
	
	if (mProfileNavigationController) {
		[mProfileNavigationController release];
		mProfileNavigationController = nil;
	}
	
	if (mFriendNavigationController) {
		[mFriendNavigationController release];
		mFriendNavigationController = nil;
	}
	
	if (mSearchNavigationController) {
		[mSearchNavigationController release];
		mSearchNavigationController = nil;
	}
    
	if (mSearchNearbyViewController) {
		[mSearchNearbyViewController release];
		mSearchNearbyViewController = nil;
	}
	
	if (mMainViewController) {
		[mMainViewController release];
		mMainViewController = nil;
	}
	
    if (mAccountViewController) {
        [mAccountViewController release];
        mAccountViewController = nil;
    }
    
    if (mFriendNavigationController)
    {
        [mFriendNavigationController release];
        mFriendNavigationController = nil;
    }
    
    if (mLiveFeedViewController) {
        [mLiveFeedViewController release];
        mLiveFeedViewController = nil;
    }
    [super dealloc];
}

#pragma mark -
#pragma mark MainViewControllerDelegate

- (void)mainViewControllerSelectAroundFriend:(MainViewController *)controller
{
    [[self.view viewWithTag:(mChoosePageIndex+100)] removeFromSuperview];		
    self.choosePageIndex = 3;
    
    if (mMyFriendsViewController == nil) {
        mMyFriendsViewController = [[MyFriendsViewController alloc] init];
        [mFriendNavigationController pushViewController:mMyFriendsViewController animated:NO];
    }
    [self.view addSubview:mFriendNavigationController.view];
}

#pragma mark -
#pragma mark Action

- (void)procBottomBtn:(id)sender
{
	UIButton *button = (UIButton *)sender;
	
	if ((button.tag >= 0) && (button.tag < BottomButtonCount)) {

        [[self.view viewWithTag:(mChoosePageIndex+100)] removeFromSuperview];		
		self.choosePageIndex = button.tag;
	}else {
		return;
	}



    switch (button.tag) {
        case 0:
            if (mMainViewController == nil) {
                mMainViewController = [[MainViewController alloc] init];
                mMainViewController.delegate = self;
				[mHomeNavigationController pushViewController:mMainViewController animated:NO];
            }
			
			[self.view addSubview:mHomeNavigationController.view];
            break;
        case 1:
        { 
            if (mLiveFeedViewController == nil) {
                mLiveFeedViewController = [[LiveFeedViewController alloc] init];
                [mLiveNavigationController pushViewController:mLiveFeedViewController animated:YES];
            }
            
            [self.view addSubview:mLiveNavigationController.view];
            break;
        }
        case 2:
            if (mAccountViewController == nil) {
                mAccountViewController = [[AccountViewController alloc] init];
                [mProfileNavigationController pushViewController:mAccountViewController animated:NO];
            }
            
            [self.view addSubview:mProfileNavigationController.view];
            break;
        case 3:
            if (mMyFriendsViewController == nil) {
                mMyFriendsViewController = [[MyFriendsViewController alloc] init];
                [mFriendNavigationController pushViewController:mMyFriendsViewController animated:NO];
            }
            [self.view addSubview:mFriendNavigationController.view];
            break;
        case 4:
            
            if (mSearchNearbyViewController == nil) {
                mSearchNearbyViewController = [[SearchNearbyViewController alloc] init];
				[mSearchNavigationController pushViewController:mSearchNearbyViewController animated:NO];
            }
            [self.view addSubview:mSearchNavigationController.view];
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
#pragma mark Public

- (void)displayViewControllerWithIndex:(NSInteger)index
{
	[[self.view viewWithTag:(mChoosePageIndex+100)] removeFromSuperview];
	self.choosePageIndex = index;
	
	if (index == 4) {
		if (mSearchNearbyViewController == nil) {
			mSearchNearbyViewController = [[SearchNearbyViewController alloc] init];
			[mSearchNavigationController pushViewController:mSearchNearbyViewController animated:NO];
		}
		[self.view addSubview:mSearchNavigationController.view];
	}
	if (index == 0) {
        
        if (mMainViewController == nil) {
            mMainViewController = [[MainViewController alloc] init];
            mMainViewController.delegate = self;
            [mHomeNavigationController pushViewController:mMainViewController animated:NO];
        }
        
        [self.view addSubview:mHomeNavigationController.view];
	}
}
	
#pragma mark -
#pragma mark Private

@end
