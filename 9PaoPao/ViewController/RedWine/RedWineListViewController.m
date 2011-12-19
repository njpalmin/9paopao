    //
//  RedWineListViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RedWineListViewController.h"
#import "PaoPaoCommon.h"
#import "PaoPaoConstant.h"
#import "WineDetailView.h"
#import "RedWineDetailViewController.h"
#import "AppDelegate.h"
#import "MainSegmentViewController.h"

@implementation RedWineListViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	CGRect			bounds, tableviewFrame, searchBarframe;
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
        
        // ---------------tableView-------------
        tableviewFrame.origin.x = bounds.origin.x;
		tableviewFrame.origin.y = bounds.origin.y + SearchBarHeight;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - SearchBarHeight;
		
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
        
        mRedWineResult = [[NSMutableArray alloc] initWithCapacity:0];
				
    }while (0);
	
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
	
	if (mTableView) {
		[mTableView release];
		mTableView = nil;
	}
	
	if (mRedWineResult) {
		[mRedWineResult release];
		mRedWineResult = nil;
	}
    
    if (mSearchBar) {
		[mSearchBar release];
		mSearchBar = nil;
	}
    if (mProgressView) {
        [mProgressView removeFromSuperview];
        [mProgressView release];
        mProgressView = nil;
    }
    [super dealloc];
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
    [self displayProgressView];
    [self startRedWineSearching];
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
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return [mRedWineResult count];
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{	
	static NSString		*PlaceCellIdentifier = @"CellIdentifier";
	UIImageView			*accessView = nil;
	// temp test 
	WineDetailView		*cell = nil;
	
	cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:PlaceCellIdentifier];
	if (cell == nil)
	{
		cell = [[[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlaceCellIdentifier] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	//accessView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right-arrow.png"]];
	//cell.accessoryView = accessView;
	
	[cell setWineDetailRecord:[mRedWineResult objectAtIndex:indexPath.section]];
	
	[accessView release];
	accessView = nil;
	
	return cell;		
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    WineDetailInfo  *wineInfo = nil;
    
    wineInfo = [mRedWineResult objectAtIndex:indexPath.section];
    [self startSearchRedWineDetailInfoWithId:wineInfo.wineId];
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
#pragma mark SearchManagerDelegate

- (void)searchManagerDidFinish:(SearchManager *)manager
{
    SearchManager   *defaultManager = nil;
    
    do{
        defaultManager= [SearchManager defaultSearchManager];
        break_if(defaultManager == nil)
        
        if (defaultManager.searchType == SearchType_BreweryList) {
            [mRedWineResult removeAllObjects];
            [mRedWineResult addObjectsFromArray:defaultManager.wineListResults];
            
            [mTableView reloadData];
        }
        else if (defaultManager.searchType == SearchType_WineDetail)
        {
            RedWineDetailViewController *controller = nil;
            WineDetailInfo              *searchResult = nil;
            
            searchResult = defaultManager.wineDetailInfo;
            controller = [[RedWineDetailViewController alloc] init];
            controller.redWineInfo = searchResult;

            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            controller = nil;
        }
        
    }while(0);
    
    [self procProgressViewCancel:nil];
}

- (void)searchManager:(SearchManager *)manager didFailWithError:(NSError*)error
{
    [self procProgressViewCancel:nil];
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:nil action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = NSLocalizedString(@"Red Wine Area Title", nil);
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    
    [leftItem release];
    leftItem = nil;
    
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

- (void)displayProgressView
{
    MainSegmentViewController   *controller = nil;
    id<AppDelegate>             delegate = nil;
    
    delegate = (id<AppDelegate>)[[UIApplication sharedApplication] delegate];
    controller = [delegate mainSegmentViewController];
    
    [self prepareProgressView];
    mProgressView.alpha = 1.0;
    mProgressView.label.text = NSLocalizedString(@"Searching...,wait a moment", nil);
    [mProgressView.indicator startAnimating];
    
    [controller.view addSubview:mProgressView];
}

- (void)startRedWineSearching
{
    SearchManager   *defaultManager = nil;
    NSString        *keyWord = nil;
    
    do{
        defaultManager= [SearchManager defaultSearchManager];
        break_if(defaultManager == nil)
        
        defaultManager.delegate = self;
        
        keyWord = mSearchBar.text;
        break_if(keyWord == nil);
        
        defaultManager.searchType = SearchType_BreweryList;
        [defaultManager startSearchWithKeyword:keyWord withType:SearchType_BreweryList withPage:2];
        
    }while(0);
}

- (void)startSearchRedWineDetailInfoWithId:(NSString *)wineId
{
    SearchManager   *defaultManager = nil;
    
    do{
        defaultManager= [SearchManager defaultSearchManager];
        break_if(defaultManager == nil)
        
        defaultManager.delegate = self;
        
        defaultManager.searchType = SearchType_WineDetail;
        [self displayProgressView];
        [defaultManager startSearchWineDetailWithId:wineId withType:SearchType_WineDetail];
        
    }while(0);
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)procProgressViewCancel:(id)sender
{
    SearchManager   *defaultManager = nil;
    
    defaultManager = [SearchManager defaultSearchManager];
    [defaultManager cancelSearch];
    
    [mProgressView removeFromSuperview];
}

@end
