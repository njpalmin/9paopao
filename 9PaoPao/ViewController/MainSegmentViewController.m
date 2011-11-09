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
            
    [mNavigationController popViewControllerAnimated:NO];
        
    switch (button.tag) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            if (mSearchNearbyViewController == nil) {
                mSearchNearbyViewController = [[SearchNearbyViewController alloc] init];
            }
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

@end
