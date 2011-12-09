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

#define UserInfoViewHeight  85

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
    if (mUserInfoView) {
        [mUserInfoView release];
        mUserInfoView = nil;
    }
    
    if (mTableView) {
        [mTableView release];
        mTableView = nil;
    }
    
    if (mTabSelectView) {
        [mTabSelectView release];
        mTabSelectView = nil;
    }
    
    if (mDrinkTrackerBtn) {
        [mDrinkTrackerBtn release];
        mDrinkTrackerBtn = nil;
    }
    
    if (mCommentBtn) {
        [mCommentBtn release];
        mCommentBtn = nil;
    }

    if (mCollectionBtn) {
        [mCollectionBtn release];
        mCollectionBtn = nil;
    }
    
    if (mCollections) {
        [mCollections release];
        mCollections = nil;
    }
    
    if (mFootView) {
        [mFootView release];
        mFootView = nil;
    }
    
    if (mAddMoreBtn) {
        [mAddMoreBtn release];
        mAddMoreBtn = nil;
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
        break_if(![self prepareFootView]);
        
        userInfoframe = CGRectMake(10, 0, bounds.size.width, 0);
        mUserInfoView = [[UserInfoView alloc] initWithFrame:userInfoframe];
        [mUserInfoView setUserInfos:nil];
        [containerView addSubview:mUserInfoView];
        
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
        
        // prepare data
        NSMutableDictionary     *dictionary = nil;
        NSArray                 *wineData = nil;
        
        mCollections = [[NSMutableArray alloc] init];
        
        wineData = [[NSArray alloc] initWithObjects:@"鸡尾酒1", @"鸡尾酒2", nil];
        dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:@"鸡尾酒" forKey:PPWineKindName];
        [dictionary setObject:[NSNumber numberWithInt:PPCocktailFlag] forKey:PPWineKindFlag];
        [dictionary setObject:wineData forKey:PPWineKindContent];

        [mCollections addObject:dictionary];
        
        [dictionary release];
        dictionary = nil;
        
        [wineData release];
        wineData = nil;
        
        wineData = [[NSArray alloc] initWithObjects:@"红酒1", @"红酒2", nil];
        dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:@"红酒" forKey:PPWineKindName];
        [dictionary setObject:[NSNumber numberWithInt:PPRedWineFlag] forKey:PPWineKindFlag];
        [dictionary setObject:wineData forKey:PPWineKindContent];

        [mCollections addObject:dictionary];

        [dictionary release];
        dictionary = nil;
        
        [wineData release];
        wineData = nil;
        
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
        return [mCollections count];
	}
	return 0;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    if (mCurSelectTab == SelectTabDrinkTracker) {
		return 1;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
		return 1;
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        return [[[mCollections objectAtIndex:section] objectForKey:PPWineKindContent] count];
	}
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{	
	if (mCurSelectTab == SelectTabDrinkTracker) {
		
		static NSString		*WineCellIdentifier = @"DrinkTracterCell";
		UIImageView			*accessView = nil;
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:WineCellIdentifier];
		if (cell == nil)
		{
			cell = [[[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WineCellIdentifier] autorelease];
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
		static NSString		*PlaceCellIdentifier = @"CommentCell";
		UIImageView			*accessView = nil;
		// temp test 
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier];
		if (cell == nil)
		{
			cell = [[[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellIdentifier] autorelease];
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
		static NSString		*PlaceCellIdentifier = @"CollectionCell";
		UITableViewCell		*cell = nil;
        NSArray             *contents = nil;
        NSNumber            *wineKindFlag = nil;
		
		cell = [tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        contents = [[mCollections objectAtIndex:indexPath.section] valueForKey:PPWineKindContent];
        cell.textLabel.text = [contents objectAtIndex:indexPath.row];
        
        wineKindFlag = [[mCollections objectAtIndex:indexPath.section] valueForKey:PPWineKindFlag];
        switch ([wineKindFlag intValue]) {
            case PPRedWineFlag:
                cell.imageView.image = [UIImage imageNamed:@"redwine-icon.png"];
                break;
                
            case PPBeerFlag:
                cell.imageView.image = [UIImage imageNamed:@"beer-icon.png"];
                break;
                
            case PPCocktailFlag:
                cell.imageView.image = [UIImage imageNamed:@"cocktail-icon.png"];
                break;
                
            default:
                break;
        }
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
    if (mCurSelectTab == SelectTabDrinkTracker) {
        return TableViewRowHeight;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
        return TableViewRowHeight;
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        return 35;
    }

	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (mCurSelectTab == SelectTabDrinkTracker) {
        return TableViewSectionPadding;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
        return TableViewSectionPadding;
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        return 30+TableViewSectionPadding;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (mCurSelectTab == SelectTabDrinkTracker) {
        return TableViewSectionPadding;
	}
	else if (mCurSelectTab == SelectTabComment)
	{
        return TableViewSectionPadding;
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        if (section == ([mCollections count]-1)) {
            return (SearchKindBtnHeight + TableViewSectionPadding*2);
        }else{
            return TableViewSectionPadding;
        }
    }

    return TableViewSectionPadding;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (mCurSelectTab == SelectTabDrinkTracker) {
        UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)];
        sectionPaddingView.backgroundColor = [UIColor clearColor];
        return [sectionPaddingView autorelease];
	}
	else if (mCurSelectTab == SelectTabComment)
	{
        UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)];
        sectionPaddingView.backgroundColor = [UIColor clearColor];
        return [sectionPaddingView autorelease];
	}
	else if (mCurSelectTab == SelectTabCollection)
	{
        UIView          *headerView = nil;
        UIImageView     *imageView = nil;
        UILabel         *label = nil;
        
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        
        imageView = [[[UIImageView alloc] initWithFrame:headerView.frame] autorelease];
        imageView.image = [UIImage imageNamed:@"wineheader-bg.png"];
        [headerView addSubview:imageView];
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 30)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:PaoPaoFont size:16.0];
        label.text = [[mCollections objectAtIndex:section] valueForKey:PPWineKindName];
        [headerView addSubview:label];
        
        return [headerView autorelease];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ((mCurSelectTab == SelectTabCollection) && (section == ([mCollections count]-1))) {
        return mFootView;
    }else{
        UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)];
        sectionPaddingView.backgroundColor = [UIColor clearColor];
        return [sectionPaddingView autorelease];
    }
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
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
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
    
    xPos = (bounds.size.width - 2*92 - 114 - 2*SearchKindBtnPadding)/2;
	
    mDrinkTrackerBtn = [[PaoPaoCommon getImageButtonWithName:@"drink-tracker-selected.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self] retain];
    mDrinkTrackerBtn.tag = SelectTabDrinkTracker;
    mDrinkTrackerBtn.frame = CGRectMake(xPos, 0, 114, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
    
    mCommentBtn = [[PaoPaoCommon getImageButtonWithName:@"comments-button.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self] retain];
    mCommentBtn.tag = SelectTabComment;
    mCommentBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    mCollectionBtn = [[PaoPaoCommon getImageButtonWithName:@"collection-button.png" highlightName:nil action:@selector(procSearchTabBtn:) target:self] retain];
    mCollectionBtn.tag = SelectTabCollection;
    mCollectionBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    //xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    [mTabSelectView addSubview:mDrinkTrackerBtn];
    [mTabSelectView addSubview:mCommentBtn];
    [mTabSelectView addSubview:mCollectionBtn];
	
	return YES;
}

- (BOOL)prepareFootView
{
    CGRect  frame;
    
    mFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (SearchKindBtnHeight + TableViewSectionPadding*2))];
    mAddMoreBtn = [[PaoPaoCommon getImageButtonWithName:@"addmore-button.png" highlightName:nil action:@selector(procAddMore:) target:self] retain];
    
    frame = mAddMoreBtn.frame;
    frame.origin.x = (320-frame.size.width)/2;
    frame.origin.y = TableViewSectionPadding;

    mAddMoreBtn.frame = frame;
    
    [mFootView addSubview:mAddMoreBtn];
    
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
            
            drinkTrackerImage = [UIImage imageNamed:@"drink-tracker-selected.png"];
            commentImage = [UIImage imageNamed:@"comments-button.png"];;
            collectionImage = [UIImage imageNamed:@"collection-button.png"];;
            
			break;
        case SelectTabComment:
            
            drinkTrackerImage = [UIImage imageNamed:@"drink-tracker-selected.png"];
            commentImage = [UIImage imageNamed:@"comments-button-selected.png"];;
            collectionImage = [UIImage imageNamed:@"collection-button.png"];;
            
			break;
        case SelectTabCollection:
            
            drinkTrackerImage = [UIImage imageNamed:@"drink-tracker-selected.png"];
            commentImage = [UIImage imageNamed:@"comments-button.png"];;
            collectionImage = [UIImage imageNamed:@"collection-button-selected.png"];;
            
			break;
        default:
            break;
    }
    [mDrinkTrackerBtn setBackgroundImage:drinkTrackerImage forState:UIControlStateNormal];
    [mCommentBtn setBackgroundImage:commentImage forState:UIControlStateNormal];
    [mCollectionBtn setBackgroundImage:collectionImage forState:UIControlStateNormal];
    
	[mTableView reloadData];
}

- (void)procAddMore:(id)sender
{
    
}
@end
