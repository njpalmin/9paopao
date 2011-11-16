    //
//  WineDetailViewController.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
 
#import "WineDetailViewController.h"
#import "PaoPaoConstant.h"
#import "PaoPaoCommon.h"
#import "StarMarkView.h"
#import "ThumbMarkView.h"
#import "CommentViewController.h"
#import "UserInfoView.h"

#define CellWineImageTag			555
#define CellWineNameLabelTag		556
#define CellWineKindLabelTag		557
#define CellWineDegreeLabelTag		558
#define CellWineMarkLabelTag		559
#define CellWineCommentLabelTag		560

@implementation WineDetailViewController

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
		
		[[cell.contentView viewWithTag:CellWineImageTag] removeFromSuperview];
		[[cell.contentView viewWithTag:CellWineNameLabelTag] removeFromSuperview];
		[[cell.contentView viewWithTag:CellWineKindLabelTag] removeFromSuperview];
		[[cell.contentView viewWithTag:CellWineDegreeLabelTag] removeFromSuperview];
		[[cell.contentView viewWithTag:CellWineMarkLabelTag] removeFromSuperview];
		[[cell.contentView viewWithTag:CellWineCommentLabelTag] removeFromSuperview];
		
		//---------wine image label------------
		UIImage     *image = nil;
		UIImageView *leftImageView = nil;
		
		image = [UIImage imageNamed:@"wine-icon-bg.png"];
		leftImageView = [[UIImageView alloc] initWithImage:image];
		leftImageView.frame = CGRectMake(8, 10, image.size.width, image.size.height);
		leftImageView.tag = CellWineImageTag;
		
		[cell.contentView addSubview:leftImageView];
		
		[leftImageView release];
		leftImageView = nil;
		//---------wine image label------------
		
		//---------wine info label-------------
		UILabel		*wineName = nil;
		UILabel		*wineKind = nil;
		UILabel		*wineDegree = nil;
		UILabel		*wineMark = nil;
		UILabel		*wineComment = nil;
		CGFloat		yPos = 5;
		
		wineName = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight+4)];
        [wineName setTextColor:[UIColor redColor]];
        [wineName setFont:[UIFont systemFontOfSize:14.0]];
        [wineName setBackgroundColor:[UIColor clearColor]];
		wineName.tag = CellWineNameLabelTag;
        [cell.contentView addSubview:wineName];
		yPos += WineDetailInfoLabelHeight + 4;
		
		wineKind = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineKind setTextColor:[UIColor blackColor]];
        [wineKind setFont:[UIFont systemFontOfSize:13.0]];
        [wineKind setBackgroundColor:[UIColor clearColor]];
		wineKind.tag = CellWineKindLabelTag;
        [cell.contentView addSubview:wineKind];
		yPos += WineDetailInfoLabelHeight;
		
		wineDegree = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineDegree setTextColor:[UIColor blackColor]];
        [wineDegree setFont:[UIFont systemFontOfSize:13.0]];
        [wineDegree setBackgroundColor:[UIColor clearColor]];
		wineDegree.tag = CellWineDegreeLabelTag;
        [cell.contentView addSubview:wineDegree];
		yPos += WineDetailInfoLabelHeight;
		
		wineMark = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineMark setTextColor:[UIColor blackColor]];
        [wineMark setFont:[UIFont systemFontOfSize:13.0]];
        [wineMark setBackgroundColor:[UIColor clearColor]];
		wineMark.tag = CellWineMarkLabelTag;
        [cell.contentView addSubview:wineMark];
		yPos += WineDetailInfoLabelHeight;
		
		wineComment = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineComment setTextColor:[UIColor blackColor]];
        [wineComment setFont:[UIFont systemFontOfSize:13.0]];
        //[wineComment setBackgroundColor:[UIColor clearColor]];
		wineComment.tag = CellWineCommentLabelTag;
        [cell.contentView addSubview:wineComment];
		yPos += WineDetailInfoLabelHeight;
		
		//-----------
		[wineName setText:@"红酒1"];
		[wineKind setText:[NSString stringWithFormat:NSLocalizedString(@"Kind:", nil), @"葡萄酒"]];
		[wineDegree setText:[NSString stringWithFormat:NSLocalizedString(@"Wine Degree:", nil), @"20%"]];
		[wineMark setText:[NSString stringWithFormat:NSLocalizedString(@"Expert Mark:", nil), @"1/100"]];
		[wineComment setText:[NSString stringWithFormat:NSLocalizedString(@"Comment Number:", nil), @"15"]];
		//-----------
		
		[wineName release];
		wineName = nil;
		
		[wineKind release];
		wineKind = nil;
		
		[wineDegree release];
		wineDegree = nil;
		
		[wineMark release];
		wineMark = nil;
		
		[wineComment release];
		wineComment = nil;
		//---------wine info label-------------

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
	return (TableViewRowHeight-5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 400;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //UIView  *sectionPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
//    sectionPaddingView.backgroundColor = [UIColor greenColor];
//    return [sectionPaddingView autorelease];
	
	return mFooterView;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	CGRect	uploadImageFrame;
	
	uploadImageFrame = mUploadImage.frame;
	uploadImageFrame.size.width = image.size.width;
	uploadImageFrame.size.height = image.size.height;
	
	[mUploadImage setImage:image];
	mUploadImage.frame = uploadImageFrame;
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
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
    self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
    
    [leftItem release];
    leftItem = nil;
    
    return YES;
}

#define WinePlaceViewHeight		80
#define FooterViewPadding		5
- (BOOL)prepareFooterView
{
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
	[whereWine setFont:[UIFont systemFontOfSize:13.0]];
	[whereWine setText:NSLocalizedString(@"Where Drink Wine", nil)];
	[winePlaceView addSubview:whereWine];
	
	placeInfo = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 5+WineDetailInfoLabelHeight, 170, 4*WineDetailInfoLabelHeight)];
	[placeInfo setTextColor:[UIColor blackColor]];
	[placeInfo setFont:[UIFont systemFontOfSize:13.0]];
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
	UIImageView	*mapView = nil;
	UIImage		*mapImage = nil;
	
	mapImage = [UIImage imageNamed:@"bar-map-bg.png"];
	mapView = [[[UIImageView alloc] initWithImage:mapImage] autorelease];
	mapView.frame = CGRectMake(210, yPos, WinePlaceViewHeight, WinePlaceViewHeight);
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
	
	button = [PaoPaoCommon getBarButtonWithTitle:@"上传照片1" imageName:@"upload.png" highlightedImageName:nil action:@selector(procUploadBtn:) target:self];
    button.frame = CGRectMake(xPos, yPos, SearchKindBtnWidth, SearchKindBtnHeight);
	
	//----------
	
	yPos += 30;
	
	//------------
	mUploadImage = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, 0, 0)];
	//------------
	[footView addSubview:winePlaceView];
	[footView addSubview:userView];
	[footView addSubview:markView];
    [footView addSubview:userView];
	[footView addSubview:thumbView];
	[footView addSubview:button];
	[footView addSubview:mUploadImage];
	
	mFooterView = [footView retain];
	mFooterView.frame = CGRectMake(10, 5, 300, 400);
	mFooterView.backgroundColor = [UIColor clearColor];

	//mFooterHeight += 
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)procUploadBtn:(id)sender
{
//	UIButton	*button = nil;
//	
//	button = (UIButton *)sender;
//	
//	[button setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateNormal];
//	[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//	
//	UIImagePickerController	*imagePicker = nil;
//	
//	imagePicker = [[UIImagePickerController alloc] init];
//	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//	imagePicker.delegate = self;
//	
//	[self presentModalViewController:imagePicker animated:YES];
//	
//	[imagePicker release];
//	imagePicker = nil;
    CommentViewController *comm = [[CommentViewController alloc] init];
    comm.view.frame = CGRectMake(0, 0, 320, 410);
    [self.navigationController pushViewController:comm animated:YES];
    //[self presentModalViewController:comm animated:YES];
    [comm release];
}

@end
