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
#define	BottomButtonOriginY		410

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

	pool = [[NSAutoreleasePool alloc] init];
	
	do {
		
		bound = [[UIScreen mainScreen] bounds];
		
		container = [[UIView alloc] initWithFrame:bound];
		container.backgroundColor = [UIColor whiteColor];
		container.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		// -----bottom button-----
		
		normalButtonImage = [[NSArray arrayWithObjects:@"home.png", @"live-feed.png", @"my-profile.png", 
									  @"friend.png", @"search.png", nil] retain];
		chooseButtonImage = [[NSArray arrayWithObjects:@"home-selected.png", @"live-feed-selected.png", @"my-profile-selected.png", 
									  @"friend-selected.png", @"search-selected.png", nil] retain];
		
		mButtonArray = [[NSMutableArray alloc] initWithCapacity:BottomButtonCount];
		break_if(mButtonArray == nil);
		
		for (int i = 0; i < BottomButtonCount; i++) {
			button = [PaoPaoCommon getImageButtonWithName:[normalButtonImage objectAtIndex:i] 
											highlightName:[chooseButtonImage objectAtIndex:i] 
												   action:@selector(procBottomBtn:) target:self];
			buttonFrame = button.frame;
			buttonFrame.origin = CGPointMake(xOrigin, BottomButtonOriginY);
			[button setFrame:buttonFrame];
			button.tag = i;
			xOrigin += buttonFrame.size.width;
			[mButtonArray addObject:button];
		}
		
		for (int i = 0; i < [mButtonArray count]; i++) {
			[container addSubview:[mButtonArray objectAtIndex:i]];
		}
		
		self.choosePageIndex = 0;
		// -----bottom button-----

		self.view = container;
		
	} while (0);
	
	[container release];
	container = nil;
	
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
}

- (void)setChoosePageIndex:(int)index
{
	mChoosePageIndex = index;
	
	for (int i = 0; i < [mButtonArray count]; i++) {
		if (i == index) {
			
			[[mButtonArray objectAtIndex:i] setBackgroundImage:[chooseButtonImage objectAtIndex:i] forState:UIControlStateNormal];

		}else {
			[[mButtonArray objectAtIndex:i] setBackgroundImage:[normalButtonImage objectAtIndex:i] forState:UIControlStateNormal];
		}
	}
}

@end
