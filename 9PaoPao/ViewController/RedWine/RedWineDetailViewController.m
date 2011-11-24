    //
//  RedWineDetailViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RedWineDetailViewController.h"
#import "PaoPaoCommon.h"

#define DetailDescriptionTitleTag   133
#define WhereEnjoyWineTitleTag      134

@implementation RedWineDetailViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	CGRect          bounds, tableviewFrame;
    UIView          *containerView = nil;
    UIImageView     *backgroundView = nil;
	
    do{
        bounds = [[UIScreen mainScreen] bounds];
		
        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search-bg.png"]] autorelease];
        backgroundView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
        
        [containerView addSubview:backgroundView];
        
        break_if(![self prepareNavigationBar]);
		break_if(![self prepareHeaderView]);
		break_if(![self prepareFooterView]);
        
        // ---------------tableView-------------
        tableviewFrame = bounds;
		
        mTableView = [[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStyleGrouped];       
        mTableView.autoresizesSubviews = YES;
        mTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		mTableView.backgroundColor = [UIColor clearColor];
        
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        self.view = containerView;
        
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
    
    if (mHeaderView) {
        [mHeaderView release];
        mHeaderView = nil;
    }
    
    if (mFooterView) {
        [mFooterView release];
        mFooterView = nil;
    }
    
    if (mCollectionBtn) {
        [mCollectionBtn release];
        mCollectionBtn = nil;
    }
    
    if (mRedWineBasicInfo) {
        [mRedWineBasicInfo release];
        mRedWineBasicInfo = nil;
    }
    
    if (mToolBarView) {
        [mToolBarView release];
        mToolBarView = nil;
    }
    
    if (mMapView) {
        [mMapView release];
        mMapView = nil;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString		*CellIdentifier = @"Cell";
    UITableViewCell		*cell = nil;
	
    do {
        // 処理
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            break_if(cell == nil);
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            
            [[cell viewWithTag:DetailDescriptionTitleTag] removeFromSuperview];
            
            CGFloat     xPos = 10;
            CGFloat     yPos = 5;
            UILabel     *detailDescrip = nil;
            
            detailDescrip = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 250, 2*WineDetailInfoLabelHeight)];
            detailDescrip.textColor = [UIColor blackColor];
            detailDescrip.backgroundColor = [UIColor clearColor];
            detailDescrip.text = NSLocalizedString(@"Detail Description:", nil);
            detailDescrip.tag = DetailDescriptionTitleTag;
            
            [cell.contentView addSubview:detailDescrip];
            
            [detailDescrip release];
            detailDescrip = nil;
        }
        
        if (indexPath.section == 1) {
            
            [[cell viewWithTag:WhereEnjoyWineTitleTag] removeFromSuperview];

            CGFloat     xPos = 10;
            CGFloat     yPos = 5;
            UILabel     *whereEnjoy = nil;
            
            whereEnjoy = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 250, 2*WineDetailInfoLabelHeight)];
            whereEnjoy.textColor = [UIColor blackColor];
            whereEnjoy.backgroundColor = [UIColor clearColor];
            whereEnjoy.text = NSLocalizedString(@"Where enjoy this wine:", nil);
            whereEnjoy.tag = WhereEnjoyWineTitleTag;
            
            [cell.contentView addSubview:whereEnjoy];
            
            [whereEnjoy release];
            whereEnjoy = nil;
        }
        
	} while (0);
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	do{
		
	}while (0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return mHeaderView.frame.size.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return mHeaderView;
    }
	return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return mFooterView.frame.size.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{	
    if (section == 1) {
        return mFooterView;
    }
	return nil;
}

#pragma mark -
#pragma mark MapIconViewDelegate

- (void)mapIconViewDisplayDetailMap:(MapIconView *)mapView;
{
    
}

#pragma mark -
#pragma mark ToolBarViewDelegate

-(void)locateMySelf
{
    
}

-(void)takePhoto
{
    
}

-(void)inputPoundSign
{
    
}

-(void)follow
{
    
}

-(void)showEmotion
{
    
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"" highlightedImageName:@"" action:@selector(procReturn:) target:self];
    
    //leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(procReturn:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = NSLocalizedString(@"Red Wine Area Title", nil);
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    
    [leftItem release];
    leftItem = nil;
    
    return YES;
}

- (BOOL)prepareHeaderView
{
	UIView			*headerView = nil;
	CGFloat			xPos = 0;
    
	headerView = [[UIView alloc] init];
    
    mRedWineBasicInfo = [[RedWineInfoView alloc] init];
    mRedWineBasicInfo.frame = CGRectMake(xPos, 0, 320, 17*WineDetailInfoLabelHeight);
    [headerView addSubview:mRedWineBasicInfo];
    
    mCollectionBtn = [[PaoPaoCommon getImageButtonWithName:@"follow.png" highlightName:nil action:@selector(procCollectionBtn:) target:self] retain];
    mCollectionBtn.frame = CGRectMake(220, 40, SearchKindBtnWidth, SearchKindBtnHeight);
    [headerView addSubview:mCollectionBtn];
	
    headerView.frame = CGRectMake(0, 0, 320, 17*WineDetailInfoLabelHeight);
	
	mHeaderView = [headerView retain];
	mHeaderView.backgroundColor = [UIColor clearColor];
    
    [headerView release];
    headerView = nil;
    
    return YES;
}

- (BOOL)prepareFooterView
{
	UIView			*footView = nil;
	CGFloat			yPos = 5;
	CGFloat			xPos = 10;
	
	footView = [[UIView alloc] init];
		
	mMapView = [[MapIconView alloc] initWithFrame:CGRectMake(xPos, yPos, 300, 200)];
	mMapView.delegate = self;
    	
	yPos += 200;
    mToolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(xPos, yPos, 300, 30)];
    mToolBarView.delegate = self;
	    
    yPos += 30;
	
    [footView addSubview:mMapView];
	[footView addSubview:mToolBarView];
	
	mFooterView = [footView retain];
	mFooterView.frame = CGRectMake(0, 0, 320, yPos);
	mFooterView.backgroundColor = [UIColor clearColor];
	
    [footView release];
    footView = nil;
    
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)procCollectionBtn:(id)sender
{
    
}

@end
