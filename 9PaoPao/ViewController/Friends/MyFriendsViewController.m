//
//  MyFriendsViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyFriendsViewController.h"
#import "PaoPaoConstant.h"
#import "PaoPaoCommon.h"
#import "AppDelegate.h"
#import "MainSegmentViewController.h"
#import "UserDetailViewController.h"

#define SearchBarAndKindPadding     10

#define SearchFuncKind             39
#define AddFuncKind                40

@implementation MyFriendsViewController

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
    
    if (mTableView) {
        [mTableView release];
        mTableView = nil;
    }
    
    if (mFuncKindView) {
        [mFuncKindView release];
        mFuncKindView = nil;
    }
    
    if (mSearchBtn) {
        [mSearchBtn release];
        mSearchBtn = nil;
    }
    
    if (mAddBtn) {
        [mAddBtn release];
        mAddBtn = nil;
    }

    if (mUserResult) {
        [mUserResult release];
        mUserResult = nil;
    }
    
    if (mAddCellTitle) {
        [mAddCellTitle release];
        mAddCellTitle = nil;
    }
    
    if (mImageNames) {
        [mImageNames release];
        mImageNames = nil;
    }
    
    if (mPickerViewController) {
        [mPickerViewController release];
        mPickerViewController = nil;
    }
    
    if (mSearchCancelView) {
        [mSearchCancelView release];
        mSearchCancelView = nil;
    }
    
    if (mRangeArray) {
        [mRangeArray release];
        mRangeArray = nil;
    }
    
    if (mProgressView) {
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
        // ---------------searchbar-------------
        
        // ---------------search kind button-------------
        [self prepareFuncKindView];
        if (mFuncKindView) {
            [containerView addSubview:mFuncKindView];
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
		mTableView.separatorColor = [UIColor clearColor];
		
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        [containerView addSubview:mSearchBar];
        self.view = containerView;
        
		mUserResult = [[NSMutableArray alloc] initWithCapacity:0];
        mRangeArray = [[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], 
                        [NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:20], nil] retain];
        mImageNames = [[NSArray alloc] initWithObjects:@"gmail-icon.png", @"sina-icon.png", @"renren-icon.png", @"kaixin-icon.png", @"google-icon.png", @"baidu-icon.png", nil];
        mAddCellTitle = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Gmail", nil), 
                         NSLocalizedString(@"Share to Sina Weibo", nil), NSLocalizedString(@"Share to renren", nil), 
                         NSLocalizedString(@"Share to kaixin", nil), NSLocalizedString(@"Share to Google", nil),
                         NSLocalizedString(@"Share to Baidu Collection", nil), nil];
    }while (0);
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
	if (mCurFuncKind == AddFuncKind) {
		return 6;
	}
	else if (mCurFuncKind == SearchFuncKind)
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
    if (mCurFuncKind == AddFuncKind)
	{
		static NSString *identifier = @"AddCellIdentifier";
        UITableViewCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        NSString *imageName = [mImageNames objectAtIndex:indexPath.section];
        cell.imageView.image = [UIImage imageNamed:imageName];
        
        NSString *title = [mAddCellTitle objectAtIndex:indexPath.section];
        cell.textLabel.text = title;
        
        cell.textLabel.font = [UIFont fontWithName:PaoPaoFont size:16];
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        if ((indexPath.section +1 )%2 == 0) {
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        return cell;
                
	}
	else if (mCurFuncKind == SearchFuncKind)
	{
		UserResultViewCell	*cell = nil;
		static NSString		*UserCellIdentifier = @"UserCell";
		NSArray				*tempTest = nil;
		
		tempTest = [[[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", nil] autorelease];
		cell = (UserResultViewCell*)[tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
		if (cell == nil)
		{
			cell = [[[UserResultViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCellIdentifier] autorelease];
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
    if (mCurFuncKind == AddFuncKind)
    {		
	}
	else if (mCurFuncKind == SearchFuncKind)
	{

	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mCurFuncKind == AddFuncKind)
    {
        return 40;
	}
	else if (mCurFuncKind == SearchFuncKind)
	{
        return TableViewRowHeight;
	}
	return 0;
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
    UIButton            *rightButton = nil;
    
    rightButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procChooseRange:) target:self];
    
    //rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    rightItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"SearchRange", nil), mSearchRange] style:UIBarButtonItemStylePlain target:self action:@selector(procChooseRange:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.title = NSLocalizedString(@"My Friends Page Title", nil);
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    mCurFuncKind = SearchFuncKind;
    
    [rightItem release];
    rightItem = nil;
    
    return YES;
}

- (BOOL)prepareFuncKindView
{
    CGRect  kindFrame, bounds;
    CGFloat xPos = 0;
    
    bounds = [[UIScreen mainScreen] bounds];
    
    kindFrame.origin.x = bounds.origin.x;
    kindFrame.origin.y = bounds.origin.y + SearchBarHeight + SearchBarAndKindPadding;
    kindFrame.size.width = bounds.size.width;
    kindFrame.size.height = SearchKindBtnHeight;
    
    mFuncKindView = [[UIView alloc] initWithFrame:kindFrame];
    mFuncKindView.backgroundColor = [UIColor clearColor];
    
    xPos = (bounds.size.width - 2*SearchKindBtnWidth - 1*SearchKindBtnPadding)/2;
	
    mSearchBtn = [[PaoPaoCommon getImageButtonWithName:@"friends-search-select.png" highlightName:nil action:@selector(procFuncKindBtn:) target:self] retain];
    mSearchBtn.tag = SearchFuncKind;
    mSearchBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
    
    mAddBtn = [[PaoPaoCommon getImageButtonWithName:@"frineds-add.png" highlightName:nil action:@selector(procFuncKindBtn:) target:self] retain];
    mAddBtn.tag = AddFuncKind;
    mAddBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    //xPos += SearchKindBtnWidth + SearchKindBtnPadding;
	
    [mFuncKindView addSubview:mSearchBtn];
    [mFuncKindView addSubview:mAddBtn];
	
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
/*    
    SearchManager   *defaultManager = nil;
    NSString        *keyWord = nil;
    
    do{
        defaultManager= [SearchManager defaultSearchManager];
        break_if(defaultManager == nil)
        
        defaultManager.delegate = self;
        
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
 */
}

#pragma mark -
#pragma mark Action

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

- (void)procFuncKindBtn:(id)sender
{
    UIButton    *button = (UIButton *)sender;
    
    if (button == nil) {
        return;
    }
    
    UIImage     *searchImage = nil;
    UIImage     *addImage = nil;
    
	mCurFuncKind = button.tag;
    switch (button.tag) {
        case SearchFuncKind:
            
            searchImage = [UIImage imageNamed:@"friends-search-select.png"];
            addImage = [UIImage imageNamed:@"frineds-add.png"];;
            
			mTableView.separatorColor = [UIColor clearColor];
			break;
        case AddFuncKind:
            
            searchImage = [UIImage imageNamed:@"friends-search-select.png"];
            addImage = [UIImage imageNamed:@"frineds-add.png"];;
            
			mTableView.separatorColor = [UIColor lightGrayColor];
			break;
        default:
            break;
    }
    [mSearchBtn setBackgroundImage:searchImage forState:UIControlStateNormal];
    [mAddBtn setBackgroundImage:addImage forState:UIControlStateNormal];
    
	[mTableView reloadData];
}

- (void)procProgressViewCancel:(id)sender
{
    [mProgressView removeFromSuperview];
}

@end
