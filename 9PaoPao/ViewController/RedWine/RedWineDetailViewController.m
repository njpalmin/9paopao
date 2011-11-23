    //
//  RedWineDetailViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RedWineDetailViewController.h"
#import "PaoPaoCommon.h"

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
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
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
	return 500;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return mHeaderView.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return mHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 500;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{	
	return mFooterView;
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
	UILabel			*markRecord = nil;
	CGFloat			xPos = 10;
    
	headerView = [[UIView alloc] init];
    
    mCollectionBtn = [[PaoPaoCommon getImageButtonWithName:@"follow.png" highlightName:nil action:@selector(procAttentionBtn:) target:self] retain];
    mCollectionBtn.frame = CGRectMake(220, 40, SearchKindBtnWidth, SearchKindBtnHeight);
    [headerView addSubview:mCollectionBtn];
	
    headerView.frame = CGRectMake(0, 0, 320, WineDetailInfoLabelHeight);
	
	mHeaderView = [headerView retain];
	mHeaderView.backgroundColor = [UIColor clearColor];
    
    return YES;
}

- (BOOL)prepareFooterView
{
	/*
	UIView			*footView = nil;
	UIImageView		*winePlaceView = nil;
	UILabel			*whereWine = nil;
	UILabel			*placeInfo = nil;
	CGFloat			yPos = 5;
	CGFloat			xPos = 10;
	
	footView = [[UIView alloc] init];
	
	//----------place info-----------
	winePlaceView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar-info-bg.png"]] autorelease];
	winePlaceView.frame = CGRectMake(xPos, yPos, 180, WinePlaceViewHeight);
	
	whereWine = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 5, 150, WineDetailInfoLabelHeight)];
	[whereWine setTextColor:[UIColor redColor]];
	[whereWine setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
	[whereWine setText:NSLocalizedString(@"Where Drink Wine", nil)];
	[winePlaceView addSubview:whereWine];
	
	placeInfo = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 5+WineDetailInfoLabelHeight, 170, 4*WineDetailInfoLabelHeight)];
	[placeInfo setTextColor:[UIColor blackColor]];
	[placeInfo setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
	[placeInfo setBackgroundColor:[UIColor clearColor]];
	[placeInfo setText:@"餐厅/酒吧名称：红酒\n地址：中国\n联系信息：027－88888888"];
	placeInfo.numberOfLines = 4;
	[winePlaceView addSubview:placeInfo];
	
	[whereWine release];
	whereWine = nil;
	
	[placeInfo release];
	placeInfo = nil;
	//----------place info-----------
	
	//----------map view-------------
	MapIconView		*mapView = nil;
	
	mapView = [[[MapIconView alloc] initWithFrame:CGRectMake(210, yPos, WinePlaceViewHeight, WinePlaceViewHeight)] autorelease];
	mapView.delegate = self;
	//----------map view-------------
	
	yPos += WinePlaceViewHeight + FooterViewPadding;
	
	//----------user view-------------
    
    UserInfoView    *userView = nil;
    
    userView = [[[UserInfoView alloc] init] autorelease];
    userView.frame = CGRectMake(xPos, yPos, 300, 0);
    [userView setUserInfos:nil];
    //----------user view-------------
	
	yPos += userView.frame.size.height + FooterViewPadding;
	
	//--------
	StarMarkView *markView = [[[StarMarkView alloc] initWithFrame:CGRectMake(xPos+30, yPos+12, 0, 0) withStarNum:3] autorelease];
	ThumbMarkView	*thumbView = [[[ThumbMarkView alloc] initWithFrame:CGRectMake(150, yPos, 0, 0) withGoodNum:10 withBadNum:0] autorelease];
	//--------
	
	yPos += 50;
	
	//----------
	UIButton	*button = nil;
	UIButton	*commentBtn = nil;
	
	button = [PaoPaoCommon getBarButtonWithTitle:@"上传照片1" imageName:@"upload.png" highlightedImageName:nil action:@selector(procUploadBtn:) target:self];
    button.frame = CGRectMake(xPos, yPos, SearchKindBtnWidth, SearchKindBtnHeight);
	
	commentBtn = [PaoPaoCommon getBarButtonWithTitle:@"编辑评论" imageName:@"upload.png" highlightedImageName:nil action:@selector(procEditCommentBtn:) target:self];
    commentBtn.frame = CGRectMake(xPos+SearchKindBtnWidth+10, yPos, SearchKindBtnWidth, SearchKindBtnHeight);
	
	//----------
	
	yPos += 30;
	
	//------------
	mUploadImage = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, 0, 0)];
	//------------
    
    //--------comment View start-------------
    [self prepareCommentViewOnView:footView withHeight:yPos];
	//    CommentViewController *com = [[CommentViewController alloc] init];
	//    com.view.frame = CGRectMake(0, yPos, 320, 366);
	//    [footView addSubview:com.view];
	//    [com release];
	//    com =nil;
    //--------comment View end-------------
	
	[footView addSubview:winePlaceView];
	[footView addSubview:userView];
	[footView addSubview:markView];
	[footView addSubview:mapView];
    [footView addSubview:userView];
	[footView addSubview:thumbView];
	[footView addSubview:button];
	[footView addSubview:commentBtn];
	[footView addSubview:mUploadImage];
	
	mFooterView = [footView retain];
	mFooterView.frame = CGRectMake(10, 5, 300, 400);
	mFooterView.backgroundColor = [UIColor clearColor];
	
	//mFooterHeight += 
	 */
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
