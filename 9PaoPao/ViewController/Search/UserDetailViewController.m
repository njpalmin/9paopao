//
//  UserDetailViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserDetailViewController.h"
#import "PaoPaoConstant.h"
#import "PaoPaoCommon.h"
#import "UserInfoView.h"
#import "WineDetailView.h"
#import "WineDetailViewController.h"

@implementation UserDetailViewController

@synthesize markRecords = mMarkRecords;

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
    return 1;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return [mMarkRecords count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString		*CellIdentifier = @"Cell";
    WineDetailView		*cell = nil;
	
    do {
        // 処理
        cell = (WineDetailView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            break_if(cell == nil);
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		[cell setPlaceDetailRecord];

	} while (0);
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	do{
        WineDetailViewController	*controller = nil;
        WineDetailInfo              *searchResult = nil;
        
        searchResult = [[WineDetailInfo alloc] initWithCache:0 wineId:0 score:3 type:@"2" refid:0 title:@"Regment" year:@"2006年"];
        controller = [[WineDetailViewController alloc] init];
        controller.wineDetailInfo = searchResult;
        controller.title = NSLocalizedString(@"SearchUser Page Title", nil);
        
        [self.navigationController pushViewController:controller animated:YES];
        
        if (searchResult) {
            [searchResult release];
            searchResult = nil;
        }
        
        if (controller) {
            [controller release];
            controller = nil;
        }
		
	}while (0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return mHeaderView.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 105;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return mHeaderView;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:@"" action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;    
    self.navigationItem.title = NSLocalizedString(@"SearchUser Page Title", nil);
    
    [leftItem release];
    leftItem = nil;
	
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    
    return YES;
}

- (BOOL)prepareHeaderView
{
	UIView			*headerView = nil;
	UILabel			*markRecord = nil;
	CGFloat			xPos = 10;
	UserInfoView    *userInfoView = nil;
    
	headerView = [[UIView alloc] init];
    
    userInfoView = [[[UserInfoView alloc] initWithFrame:CGRectMake(10, 0, 320, 0)] autorelease];
    [userInfoView setUserInfos:nil];
    [headerView addSubview:userInfoView];
    
    mAttentionBtn = [[PaoPaoCommon getImageButtonWithName:@"follow.png" highlightName:nil action:@selector(procAttentionBtn:) target:self] retain];
    mAttentionBtn.frame = CGRectMake(220, 10, SearchKindBtnWidth, SearchKindBtnHeight);
    [headerView addSubview:mAttentionBtn];
    
    mChatBtn = [[PaoPaoCommon getImageButtonWithName:@"chat.png" highlightName:nil action:@selector(procChatBtn:) target:self] retain];
    mChatBtn.frame = CGRectMake(220, (10*2+SearchKindBtnHeight), SearchKindBtnWidth, SearchKindBtnHeight);
	[headerView addSubview:mChatBtn];
	
	markRecord = [[[UILabel alloc] initWithFrame:CGRectMake(xPos, userInfoView.frame.size.height+10, 300, WineDetailInfoLabelHeight)] autorelease];
	[markRecord setTextColor:[UIColor blackColor]];
    [markRecord setBackgroundColor:[UIColor clearColor]];
	[markRecord setFont:[UIFont systemFontOfSize:13.0]];
	[markRecord setText:@"张三的评分记录:"];
	[headerView addSubview:markRecord];
	
    headerView.frame = CGRectMake(0, 0, 320, (userInfoView.frame.size.height + WineDetailInfoLabelHeight + 5));

	mHeaderView = [headerView retain];
	mHeaderView.backgroundColor = [UIColor clearColor];
    
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)procAttentionBtn:(id)sender
{
    
}

- (void)procChatBtn:(id)sender
{
    
}

@end
