//
//  MyProfileViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyProfileViewController.h"
#import "PaoPaoConstant.h"
#import "PaoPaoCommon.h"
#import "WineDetailView.h"

#define UserInfoViewHeight  150

@implementation MyProfileViewController

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect          userInfoframe, bounds, tableviewFrame;
    UIView          *containerView = nil;
    UIImageView     *backgroundView = nil;
    
    do{
        bounds = [[UIScreen mainScreen] bounds];
        
        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search-bg.png"]] autorelease];
        backgroundView.frame = bounds;
        
        [containerView addSubview:backgroundView];
        
        break_if(![self prepareNavigationBar]);
        
        userInfoframe = CGRectMake(0, 0, bounds.size.width, 0);
        mUserInfoView = [[UserInfoView alloc] initWithFrame:userInfoframe];
        [mUserInfoView setUserInfos:nil];
        
        [self prepareTabSelectView];
        if (mTabSelectView) {
            [containerView addSubview:mTabSelectView];
        }
        
        // ---------------tableView-------------
        tableviewFrame.origin.x = bounds.origin.x;
		tableviewFrame.origin.y = bounds.origin.y + UserInfoViewHeight + SearchKindBtnHeight;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - (UserInfoViewHeight + SearchKindBtnHeight);
		
        mTableView = [[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStyleGrouped];       
        mTableView.autoresizesSubviews = YES;
        mTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		mTableView.backgroundColor = [UIColor clearColor];
		//mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		mTableView.separatorColor = [UIColor lightGrayColor];
		
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        self.view = containerView;
        
    }while (0);
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
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	if (mCurSelectTab == SelectTabDrinkTracker) {
		return 4;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
		return 5;
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        return 3;
	}
	return 0;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{	
	if (mCurSelectTab == SelectTabDrinkTracker) {
		
		static NSString		*WineCellIdentifier = @"WineCell";
		UIImageView			*accessView = nil;
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:WineCellIdentifier];
		if (cell == nil)
		{
			cell = [[[WineDetailView alloc] initWithFrame:CGRectZero reuseIdentifier:WineCellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		accessView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right-arrow.png"]];
		cell.accessoryView = accessView;
		
		[cell setPlaceDetailRecord];
		
		[accessView release];
		accessView = nil;
		
		return cell;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
		static NSString		*PlaceCellIdentifier = @"PlaceCell";
		UIImageView			*accessView = nil;
		// temp test 
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier];
		if (cell == nil)
		{
			cell = [[[WineDetailView alloc] initWithFrame:CGRectZero reuseIdentifier:PlaceCellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		accessView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right-arrow.png"]];
		cell.accessoryView = accessView;
		
		[cell setPlaceDetailRecord];
		
		[accessView release];
		accessView = nil;
		
		return cell;		
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
		static NSString		*PlaceCellIdentifier = @"PlaceCell";
		UIImageView			*accessView = nil;
		// temp test 
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier];
		if (cell == nil)
		{
			cell = [[[WineDetailView alloc] initWithFrame:CGRectZero reuseIdentifier:PlaceCellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		accessView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right-arrow.png"]];
		cell.accessoryView = accessView;
		
		[cell setPlaceDetailRecord];
		
		[accessView release];
		accessView = nil;
		
		return cell;		
	}
    
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (mCurSelectTab == SelectTabDrinkTracker) {
		
	}
	else if (mCurSelectTab == SelectTabComment)
	{
		
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return TableViewRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TableViewSectionPadding;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return TableViewSectionPadding;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)];
    sectionPaddingView.backgroundColor = [UIColor clearColor];
    return [sectionPaddingView autorelease];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)];
    sectionPaddingView.backgroundColor = [UIColor clearColor];
    return [sectionPaddingView autorelease];
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *rightItem = nil;
    UIButton            *rightButton = nil;
    
    rightButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procChooseRange:) target:self];
    
    //rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    rightItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithString:NSLocalizedString(@"Edit", nil)] style:UIBarButtonItemStylePlain target:self action:@selector(procEdit:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = NSLocalizedString(@"My Profile Title", nil);
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    mCurSelectTab = SelectTabDrinkTracker;

    [rightItem release];
    rightItem = nil;
    
    return YES;
}

- (BOOL)prepareTabSelectView
{
    CGRect  kindFrame, bounds;
    CGFloat xPos = 0;
    
    bounds = [[UIScreen mainScreen] bounds];
    
    kindFrame.origin.x = bounds.origin.x;
    kindFrame.origin.y = bounds.origin.y + UserInfoViewHeight;
    kindFrame.size.width = bounds.size.width;
    kindFrame.size.height = SearchKindBtnHeight;
    
    mTabSelectView = [[UIView alloc] initWithFrame:kindFrame];
    mTabSelectView.backgroundColor = [UIColor clearColor];
    
    xPos = (bounds.size.width - 3*SearchKindBtnWidth - 2*SearchKindBtnPadding)/2;
	
    mDrinkTrackerBtn = [PaoPaoCommon getImageButtonWithName:@"search-alcohol-selected.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self];
    mDrinkTrackerBtn.tag = SelectTabDrinkTracker;
    mDrinkTrackerBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
    
    mCommentBtn = [PaoPaoCommon getImageButtonWithName:@"search-place.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self];
    mCommentBtn.tag = SelectTabComment;
    mCommentBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    mCollectionBtn = [PaoPaoCommon getImageButtonWithName:@"search-friends.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self];
    mCollectionBtn.tag = SelectTabCollection;
    mCollectionBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    [mTabSelectView addSubview:mDrinkTrackerBtn];
    [mTabSelectView addSubview:mCommentBtn];
    [mTabSelectView addSubview:mCollectionBtn];
	
	return YES;
}

#pragma mark -
#pragma mark Action

- (void)procEdit:(id)sender
{
}                             

- (void)procSearchTabBtn:(id)sender
{
    UIButton    *button = (UIButton *)sender;
    
    if (button == nil) {
        return;
    }
    
    UIImage     *drinkTrackerImage = nil;
    UIImage     *commentImage = nil;
    UIImage     *collectionImage = nil;
    
	mCurSelectTab = button.tag;
    switch (button.tag) {
        case SelectTabDrinkTracker:
            
            drinkTrackerImage = [UIImage imageNamed:@"search-alcohol-selected.png"];
            commentImage = [UIImage imageNamed:@"search-place.png"];;
            collectionImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
            
			mTableView.separatorColor = [UIColor lightGrayColor];
			break;
        case SelectTabComment:
            
            drinkTrackerImage = [UIImage imageNamed:@"search-alcohol.png"];
            commentImage = [UIImage imageNamed:@"search-place-selected.png"];;
            collectionImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchPlace Page Title", nil);
            
			mTableView.separatorColor = [UIColor lightGrayColor];
			break;
        case SelectTabCollection:
            
            drinkTrackerImage = [UIImage imageNamed:@"search-alcohol.png"];
            commentImage = [UIImage imageNamed:@"search-place.png"];;
            collectionImage = [UIImage imageNamed:@"search-friends-selected.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchUser Page Title", nil);
			mTableView.separatorColor = [UIColor clearColor];
            
			break;
        default:
            break;
    }
    [mDrinkTrackerBtn setBackgroundImage:drinkTrackerImage forState:UIControlStateNormal];
    [mCommentBtn setBackgroundImage:commentImage forState:UIControlStateNormal];
    [mCollectionBtn setBackgroundImage:collectionImage forState:UIControlStateNormal];
    
	[mTableView reloadData];
}

@end
