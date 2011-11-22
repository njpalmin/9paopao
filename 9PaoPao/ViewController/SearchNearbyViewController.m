//
//  SearchNearbyViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011Âπ¥ __MyCompanyName__. All rights reserved.
//

#import "SearchNearbyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WineDetailViewController.h"
#import "PaoPaoCommon.h"
#import "PaoPaoConstant.h"
#import "WineDetailView.h"
#import "BarDetailViewController.h"
#import "BarDetail.h"
#import "UserDetailViewController.h"
#import "AppDelegate.h"
#import "MainSegmentViewController.h"
#import "SearchManager.h"

#define SearchBarAndKindPadding     10

#define SearchKindWine              0
#define SearchKindPlace             1
#define SearchKindUser              2

@implementation SearchNearbyViewController

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
	if (mSearchBar) {
		[mSearchBar release];
		mSearchBar = nil;
	}
	if (mTextField) {
		[mTextField release];
		mTextField = nil;
	}
	if (mTableView) {
		[mTableView release];
		mTableView = nil;
	}
	if (mSearchKindView) {
		[mSearchKindView release];
		mSearchKindView = nil;
	}
	if (mSearchWineBtn) {
		[mSearchWineBtn release];
		mSearchWineBtn = nil;
	}
	if (mSearchPlaceBtn) {
		[mSearchPlaceBtn release];
		mSearchPlaceBtn = nil;
	}
	if (mSearchUserBtn) {
		[mSearchUserBtn release];
		mSearchUserBtn = nil;
	}
	if (mWineResult) {
		[mWineResult release];
		mWineResult = nil;
	}
	if (mPlaceResult) {
		[mPlaceResult release];
		mPlaceResult = nil;
	}
	if (mUserResult) {
		[mUserResult release];
		mUserResult = nil;
	}
	if (mPickerViewController) {
		[mPickerViewController release];
		mPickerViewController = nil;
	}
	if (mRangeArray) {
		[mRangeArray release];
		mRangeArray = nil;
	}
    
    if (mProgressView) {
        [mProgressView removeFromSuperview];
        [mProgressView release];
        mProgressView = nil;
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
    CGRect          searchBarframe, bounds, tableviewFrame;
    UIView          *containerView = nil;
    UIImageView     *backgroundView = nil;

    do{
        bounds = [[UIScreen mainScreen] bounds];

        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
                
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search-bg.png"]] autorelease];
        backgroundView.frame = CGRectMake(0, SearchBarHeight, bounds.size.width, 385);
        
        [containerView addSubview:backgroundView];
        
        mSearchRange = 2;
        break_if(![self prepareNavigationBar]);
        
        // ---------------searchbar-------------
        searchBarframe.origin.x = bounds.origin.x;
        searchBarframe.origin.y = 0;
        searchBarframe.size.width = bounds.size.width;
        searchBarframe.size.height = SearchBarHeight;
        
        mSearchBar = [[UISearchBar alloc] initWithFrame:searchBarframe];
        break_if(mSearchBar == nil);
		
        mSearchBar.showsBookmarkButton = NO;
        mSearchBar.barStyle = UIBarStyleBlackTranslucent;		
        mSearchBar.autoresizesSubviews = YES;
		mSearchBar.searchResultsButtonSelected = YES;
		mSearchBar.placeholder = NSLocalizedString(@"SearchNearby SearchBar Placeholder", nil);
        mSearchBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
        mSearchBar.delegate = self;
		
        searchBarframe.origin.x = bounds.origin.x + 32;
        searchBarframe.origin.y = 5;
        searchBarframe.size.width = bounds.size.width - 45;
        searchBarframe.size.height = 29.0;
		mTextField = [[UITextField alloc] initWithFrame:searchBarframe];
        mTextField.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
		mTextField.backgroundColor = [UIColor clearColor];
        mTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		mTextField.returnKeyType = UIReturnKeyDone;
        mTextField.font = [UIFont systemFontOfSize:16.0];
        mTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		mTextField.placeholder = NSLocalizedString(@"SearchNearby SearchBar Placeholder", nil);
		mTextField.delegate = self;
		[mTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
		//[mSearchBar addSubview:mTextField];
        //[containerView addSubview:mSearchBar];
        // ---------------searchbar-------------
        
        // ---------------search kind button-------------
        [self prepareSearchKindView];
        if (mSearchKindView) {
            [containerView addSubview:mSearchKindView];
        }
        // ---------------search kind button-------------
        
        // ---------------tableView-------------
        tableviewFrame.origin.x = bounds.origin.x;
		tableviewFrame.origin.y = bounds.origin.y + SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight + SearchKindAndTablePadding;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - (SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight + SearchKindAndTablePadding);
		
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
        
        [containerView addSubview:mSearchBar];
        self.view = containerView;
        
        mWineResult = [[NSMutableArray alloc] initWithCapacity:0];
		mPlaceResult = [[NSMutableArray alloc] initWithCapacity:0];
		mUserResult = [[NSMutableArray alloc] initWithCapacity:0];
        mRangeArray = [[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], 
                       [NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:20], nil] retain];
                
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
#pragma mark UIRespons

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([mSearchBar isFirstResponder])
    {
        [mSearchBar resignFirstResponder];
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar
{
    CGRect frame;
    
    do {
		
        if (mSearchCancelView == nil)
        {
            frame = CGRectMake(0, SearchBarHeight, self.view.frame.size.width, self.view.frame.size.width);
            mSearchCancelView = [[UIView alloc] initWithFrame:frame];
            break_if(mSearchCancelView == nil);
            
            mSearchCancelView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
            
            mSearchCancelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            mSearchCancelView.opaque = YES;
        }
        
        mSearchCancelView.alpha = 0.0;
        
        [self.view insertSubview:mSearchCancelView belowSubview:mSearchBar];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        
        mSearchCancelView.alpha = 1.0;
        
        [UIView commitAnimations];
        
    } while (0);
        
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [UIView beginAnimations:nil context:[mSearchCancelView retain]];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeSearchCancelView:finished:context:)];
    
    mSearchCancelView.alpha = 0.0;
    mSearchCancelView = nil;
    
    [UIView commitAnimations];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[mSearchBar resignFirstResponder];
    
    MainSegmentViewController   *controller = nil;
    id<AppDelegate>             delegate = nil;
    
    delegate = (id<AppDelegate>)[[UIApplication sharedApplication] delegate];
    controller = [delegate mainSegmentViewController];
    
    [self prepareProgressView];
    mProgressView.alpha = 1.0;
    mProgressView.label.text = NSLocalizedString(@"Searching...,wait a moment", nil);
    [mProgressView.indicator startAnimating];
    
    [controller.view addSubview:mProgressView];
    
    [self startSearching];
}

#pragma mark -
#pragma mark Animation

- (void)removeSearchCancelView:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
    UIView *view = (UIView*)context;
    [view removeFromSuperview];
    [view release];
    view = nil;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	if (mCurSearchKind == SearchKindWine) {
		//return [mWineResult count];
		return 5;
	}
	else if (mCurSearchKind == SearchKindPlace)
	{
		//return [mPlaceResult count];
		return 4;
	}
	else if (mCurSearchKind == SearchKindUser)
	{
//		if ([mUserResult count]%4) {
//			return ([mUserResult count]/4 + 1);
//		}else {
//			return ([mUserResult count]/4);
//		}
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
	if (mCurSearchKind == SearchKindWine) {
		
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
		
		[cell setWineDetailRecord];
		
		[accessView release];
		accessView = nil;
		
		return cell;
	}
	else if (mCurSearchKind == SearchKindPlace)
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
		
		[cell setWineDetailRecord];
		
		[accessView release];
		accessView = nil;
		
		return cell;		
	}
	else if (mCurSearchKind == SearchKindUser)
	{
		UserResultViewCell	*cell = nil;
		static NSString		*UserCellIdentifier = @"UserCell";
		NSArray				*tempTest = nil;
		
		tempTest = [[[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", nil] autorelease];
		cell = (UserResultViewCell*)[tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
		if (cell == nil)
		{
			cell = [[[UserResultViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:UserCellIdentifier] autorelease];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.userInfos = tempTest;
		cell.delegate = self;
		
		return cell;
	}

    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (mCurSearchKind == SearchKindUser) {
		
	}
	else if (mCurSearchKind == SearchKindWine)
	{
		WineDetailViewController	*controller = nil;
		
		controller = [[WineDetailViewController alloc] init];
		[self.navigationController pushViewController:controller animated:YES];
		
		if (controller) {
			[controller release];
			controller = nil;
		}
	}
	else if (mCurSearchKind == SearchKindPlace)
	{
		BarDetailViewController	*controller = nil;
		
		BarDetail *object = [[BarDetail alloc] init];
		object.barName = @"红酒吧";
		object.barCommentTime = @"2011.10.12";
		object.userNickname = @"张三";
		object.barCommentMark = @"用户评分";
		NSArray *array = [NSArray arrayWithObjects:object ,object,object,object,object, nil];
		[object release];
		controller = [[BarDetailViewController alloc] initControllerWithArray:array];
		
		[self.navigationController pushViewController:controller animated:YES];
		if (controller) {
			[controller release];
			controller = nil;
		}
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
#pragma mark PopoverPickerViewControllerDelegate

- (void)popoverPickerViewControllerDidSelect:(PopoverPickerViewController *)controller
{     
    NSNumber    *number = nil;
    
    if ((controller.chooseIndex < 0) || (controller.chooseIndex >= [mRangeArray count])) {
        return;
    }   
    number = [mRangeArray objectAtIndex:controller.chooseIndex];
    mSearchRange = [number intValue];
    
    UIBarButtonItem     *rightItem;
    
    rightItem = self.navigationItem.rightBarButtonItem;
    [rightItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"SearchRange", nil), mSearchRange]];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)popoverPickerViewControllerDismiss:(PopoverPickerViewController *)controller
{
    [mPickerViewController.view removeFromSuperview];
}

#pragma mark -
#pragma mark SearchManagerDelegate

- (void)searchManagerDidFinish:(SearchManager *)manager
{
    
}

- (void)searchManager:(SearchManager *)manager didFailWithError:(NSError*)error
{
    
}

#pragma mark -
#pragma mark UserResultViewCellDelegate

- (void)userResultViewCellSelectUser
{
	UserDetailViewController    *controller = nil;
    
    controller = [[UserDetailViewController alloc] init];
    controller.markRecords = [NSArray arrayWithObjects:@"", @"", @"", nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    controller = nil;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *rightItem = nil;
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    UIButton            *rightButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procReturn:) target:self];
    rightButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procChooseRange:) target:self];
    
    //leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(procReturn:)];
    rightItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"SearchRange", nil), mSearchRange] style:UIBarButtonItemStylePlain target:self action:@selector(procChooseRange:)];
    
    //self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    mCurSearchKind = SearchKindWine;
    
    [leftItem release];
    leftItem = nil;
    
    [rightItem release];
    rightItem = nil;
    
    return YES;
}

- (BOOL)prepareSearchKindView
{
    CGRect  kindFrame, bounds;
    CGFloat xPos = 0;
    
    bounds = [[UIScreen mainScreen] bounds];
    
    kindFrame.origin.x = bounds.origin.x;
    kindFrame.origin.y = bounds.origin.y + SearchBarHeight + SearchBarAndKindPadding;
    kindFrame.size.width = bounds.size.width;
    kindFrame.size.height = SearchKindBtnHeight;
    
    mSearchKindView = [[UIView alloc] initWithFrame:kindFrame];
    mSearchKindView.backgroundColor = [UIColor clearColor];
    
    xPos = (bounds.size.width - 3*SearchKindBtnWidth - 2*SearchKindBtnPadding)/2;
	
    mSearchWineBtn = [PaoPaoCommon getImageButtonWithName:@"search-alcohol-selected.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchWineBtn.tag = SearchKindWine;
    mSearchWineBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
    
    mSearchPlaceBtn = [PaoPaoCommon getImageButtonWithName:@"search-place.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchPlaceBtn.tag = SearchKindPlace;
    mSearchPlaceBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    mSearchUserBtn = [PaoPaoCommon getImageButtonWithName:@"search-friends.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchUserBtn.tag = SearchKindUser;
    mSearchUserBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    [mSearchKindView addSubview:mSearchWineBtn];
    [mSearchKindView addSubview:mSearchPlaceBtn];
    [mSearchKindView addSubview:mSearchUserBtn];
	
	return YES;
}

- (void)prepareProgressView
{
    CGRect  bounds;
    
    bounds = [[UIScreen mainScreen] bounds];
    
    if (mProgressView == nil)
    {
        mProgressView = [[PaoPaoProgressView alloc] initWithFrame:bounds];
        [mProgressView setCancelTarget:self action:@selector(procProgressViewCancel:)];
    }
    if (mProgressView.superview != nil) {
        [mProgressView removeFromSuperview];
    }
}

- (void)startSearching
{
    SearchManager   *defaultManager = nil;
    NSString        *keyWord = nil;
    
    do{
        defaultManager= [SearchManager defaultSearchManager];
        break_if(defaultManager == nil)
        
        keyWord = mSearchBar.text;
        break_if(keyWord == nil);
        
        if (mCurSearchKind == SearchKindWine) {
            defaultManager.searchType = SearchType_WineList;
            [defaultManager startSearchWithKeyword:keyWord withType:SearchType_WineList withPage:2];
        }
        else if (mCurSearchKind == SearchKindPlace)
        {
            defaultManager.searchType = SearchType_WineryList;
        }
        else if (mCurSearchKind == SearchKindUser)
        {
            
        }
        
        
    }while(0);
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    
}

- (void)procChooseRange:(id)sender
{
    NSString                        *pickerString = nil;
    NSMutableArray                  *pickerContents = nil;
    NSNumber                        *number = nil;
    
    pickerContents = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [mRangeArray count]; i++) {
        
        number = [mRangeArray objectAtIndex:i];
        pickerString = [NSString stringWithFormat:NSLocalizedString(@"SearchRange", nil), [number intValue]];
        if (pickerString) {
            [pickerContents addObject:pickerString];
        }
    }
    
    if (mPickerViewController) {
        [mPickerViewController.view removeFromSuperview];
        [mPickerViewController release];
        mPickerViewController = nil;
    }
    mPickerViewController = [[PopoverPickerViewController alloc] init];
    mPickerViewController.chooseIndex = mSearchRange;
    mPickerViewController.pickerContent = pickerContents;
    mPickerViewController.delegate = self;
    
    [self.view addSubview:mPickerViewController.view];
    
    [pickerContents release];
    pickerContents = nil;
}                             

- (void)procSearchKindBtn:(id)sender
{
    UIButton    *button = (UIButton *)sender;
    
    if (button == nil) {
        return;
    }
        
    UIImage     *searchWineImage = nil;
    UIImage     *searchPlaceImage = nil;
    UIImage     *searchUserImage = nil;

	mCurSearchKind = button.tag;
    switch (button.tag) {
        case SearchKindWine:

            searchWineImage = [UIImage imageNamed:@"search-alcohol-selected.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
            
			mTableView.separatorColor = [UIColor lightGrayColor];
			break;
        case SearchKindPlace:
            
            searchWineImage = [UIImage imageNamed:@"search-alcohol.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place-selected.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchPlace Page Title", nil);
            
			mTableView.separatorColor = [UIColor lightGrayColor];
			break;
        case SearchKindUser:
            
            searchWineImage = [UIImage imageNamed:@"search-alcohol.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends-selected.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchUser Page Title", nil);
			mTableView.separatorColor = [UIColor clearColor];

			break;
        default:
            break;
    }
    [mSearchWineBtn setBackgroundImage:searchWineImage forState:UIControlStateNormal];
    [mSearchPlaceBtn setBackgroundImage:searchPlaceImage forState:UIControlStateNormal];
    [mSearchUserBtn setBackgroundImage:searchUserImage forState:UIControlStateNormal];

	[mTableView reloadData];
}

- (void)procProgressViewCancel:(id)sender
{
    [mProgressView removeFromSuperview];
}
@end
	

