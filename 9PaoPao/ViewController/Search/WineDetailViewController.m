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
#import "MapViewController.h"

#define CellWineImageTag			555
#define CellWineNameLabelTag		556
#define CellWineKindLabelTag		557
#define CellWineDegreeLabelTag		558
#define CellWineMarkLabelTag		559
#define CellWineCommentLabelTag		560

#define WinePlaceViewHeight		80
#define FooterViewPadding		5

#define EMOJI_HEIGHT 158

@implementation WineDetailViewController

@synthesize wineDetailInfo = mWineDetailInfo;

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

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [scoreView release];
    [toolBarView release];
    [emojiView release];
    [commentsText release];
    
	if (mWineDetailInfo) {
		[mWineDetailInfo release];
		mWineDetailInfo = nil;
	}
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
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
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
        [wineName setFont:[UIFont fontWithName:PaoPaoFont size:14.0]];
        [wineName setBackgroundColor:[UIColor clearColor]];
		wineName.tag = CellWineNameLabelTag;
        [cell.contentView addSubview:wineName];
		yPos += WineDetailInfoLabelHeight + 4;
		
		wineKind = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineKind setTextColor:[UIColor blackColor]];
        [wineKind setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [wineKind setBackgroundColor:[UIColor clearColor]];
		wineKind.tag = CellWineKindLabelTag;
        [cell.contentView addSubview:wineKind];
		yPos += WineDetailInfoLabelHeight;
		
		wineDegree = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineDegree setTextColor:[UIColor blackColor]];
        [wineDegree setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [wineDegree setBackgroundColor:[UIColor clearColor]];
		wineDegree.tag = CellWineDegreeLabelTag;
        [cell.contentView addSubview:wineDegree];
		yPos += WineDetailInfoLabelHeight;
		
		wineMark = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineMark setTextColor:[UIColor blackColor]];
        [wineMark setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [wineMark setBackgroundColor:[UIColor clearColor]];
		wineMark.tag = CellWineMarkLabelTag;
        [cell.contentView addSubview:wineMark];
		yPos += WineDetailInfoLabelHeight;
		
		wineComment = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [wineComment setTextColor:[UIColor blackColor]];
        [wineComment setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        //[wineComment setBackgroundColor:[UIColor clearColor]];
		wineComment.tag = CellWineCommentLabelTag;
        [cell.contentView addSubview:wineComment];
		//yPos += WineDetailInfoLabelHeight;
		
		//-----------
		[wineName setText:mWineDetailInfo.wineTitle];
		[wineKind setText:[NSString stringWithFormat:NSLocalizedString(@"Kind:", nil), mWineDetailInfo.wineType]];
		[wineDegree setText:[NSString stringWithFormat:NSLocalizedString(@"Wine Degree:", nil), @"20%"]];
		[wineMark setText:[NSString stringWithFormat:NSLocalizedString(@"Expert Mark:", nil), mWineDetailInfo.wineScore]];
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
    return 366*2 - (TableViewRowHeight-5) -15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{	
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
#pragma mark MapIconViewDelegate

- (void)mapIconViewDisplayDetailMap:(MapIconView *)mapView
{
    MapViewController   *mapViewController = nil;
    
    mapViewController = [[MapViewController alloc] init];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
    
    [mapViewController release];
    mapViewController = nil;
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
    //self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
    
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
	[whereWine setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
	[whereWine setText:NSLocalizedString(@"Where Drink Wine", nil)];
	[winePlaceView addSubview:whereWine];
	
	placeInfo = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 5+WineDetailInfoLabelHeight, 170, 4*WineDetailInfoLabelHeight)];
	[placeInfo setTextColor:[UIColor blackColor]];
	[placeInfo setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
	[placeInfo setBackgroundColor:[UIColor clearColor]];
	[placeInfo setText:[NSString stringWithFormat:@"餐厅/酒吧名称：%@\n地址：%@\n联系信息：88888888", mWineDetailInfo.wineWinery.wineryTitle, mWineDetailInfo.wineCountry.countryTitle]];
	//[placeInfo setText:@"È§êÂéÖ/ÈÖíÂêßÂêçÁß∞ÔºöÁ∫¢ÈÖí\nÂú∞ÂùÄÔºö‰∏≠ÂõΩ\nËÅîÁ≥ª‰ø°ÊÅØÔºö027Ôºç88888888"];
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
    return YES;
}

-(void)prepareCommentViewOnView:(UIView *)footView withHeight:(CGFloat)yPos
{
    commentsHeight = yPos;
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, yPos+14, 50, 18)];
    scoreLabel.text = @"评分";
    scoreLabel.backgroundColor = [UIColor clearColor];
    [footView addSubview:scoreLabel];
    [scoreLabel release];
    
    scoreView = [[ScoreView alloc] initWithFrame:CGRectMake(60, yPos+28, 196, 187)];
    scoreView.backgroundColor = [UIColor clearColor];

    [footView addSubview:scoreView];
    
    UILabel *commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, yPos+221, 140, 18)];
    commentsLabel.text = @"用户评论";
    commentsLabel.backgroundColor = [UIColor clearColor];
    [footView addSubview:commentsLabel];
    [commentsLabel release];
    
    commentsText = [[UITextView alloc] initWithFrame:CGRectMake(40, yPos+243, 240, 90)];
    commentsText.backgroundColor = [UIColor clearColor];
    commentsText.text = @"fhsajfsamflsamflsafmlsafslfmsfmlsmflasmfslmflsmflsamflsmflsf";
    commentsText.scrollEnabled = YES;
    commentsText.delegate = self;
    commentsText.contentInset = UIEdgeInsetsZero;
    [self addTooBarOnKeyboard];
    [footView addSubview:commentsText];
    
    toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, yPos+340, 320, 30)];
    toolBarView.backgroundColor = [UIColor clearColor];
    toolBarView.delegate = self;
    [footView addSubview:toolBarView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)procUploadBtn:(id)sender
{
	UIButton	*button = nil;
	
	button = (UIButton *)sender;
	
	[button setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	
	UIImagePickerController	*imagePicker = nil;
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	
	[imagePicker release];
	imagePicker = nil;
}

- (void)procEditCommentBtn:(id)sender
{
	CommentViewController *comm = [[CommentViewController alloc] init];
	
    [self.navigationController pushViewController:comm animated:YES];
	
    [comm release];
	comm = nil;
}
-(void)addTooBarOnKeyboard
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];  
    [topView setBarStyle:UIBarStyleBlack];  
    
    //UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];  
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];  
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];  
    [doneButton release];  
    doneButton = nil;
    [btnSpace release];  
    btnSpace = nil;
    
    [topView setItems:buttonsArray];  
    [commentsText setInputAccessoryView:topView]; 
    [topView release];
    topView = nil;
}

-(void)dismissKeyBoard  
{  
    [commentsText resignFirstResponder];  
} 

-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    [self showKeyBoard];
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [self hideKeyBoard];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [commentsText resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark LocationManagerDelegate

- (void)locationManagerUpdateHeading:(LocationManager*)controller
{
//	CLLocation	*location = nil;
//	
//	location = controller.newLocation;
}

- (void)locationManager:(LocationManager*)controller didReceiveError:(NSError*)error
{
	
}

#pragma mark -
#pragma mark EmojiViewDelegate
		 
-(void)showEmojiInMessage:(NSString *)text
{
    commentsText.text = [commentsText.text stringByAppendingString:text];
}

#pragma mark -
#pragma mark ToolBarViewDelegate
		 
-(void)locateMySelf
{
    [self hideEj];
    
	if (mLocationManager == nil) {
		mLocationManager = [[LocationManager alloc] init];
	}
	
	if (mLocationManager == nil) {
        
		NSString    *message = @"Location service not Support";
		NSString    *title = @"Alert";
		UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[noCompassAlert show];
		[noCompassAlert release];
		noCompassAlert = nil;
		
	}else{
		mLocationManager.delegate = self;
		[mLocationManager stopUpdate];
		[mLocationManager startUpdate];
	}	
}

-(void)takePhoto
{
    [self hideEj];
    
	UIImagePickerController	*imagePicker = nil;
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	
	[imagePicker release];
	imagePicker = nil;	
}

-(void)inputPoundSign
{
    [self hideEj];
    commentsText.text = [commentsText.text stringByAppendingString:@"#"];
}

-(void)follow
{
    [self hideEj];
    commentsText.text = [commentsText.text stringByAppendingString:@"@"];
}

-(void)showKeyBoard
{
    NSLog(@"keyboard shows");
    //keybord show
    mTableView.scrollEnabled = YES;
    
    //emojiview hide if poped
    if (isEmojiPoped) {
        NSLog(@"emoji hide in keyboard show ");
        mTableView.scrollEnabled = NO;
        
        [UIView beginAnimations:@"hideEmojiView" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
        [UIView commitAnimations];
        
        isEmojiPoped = NO;
    }
    
    [mTableView setContentOffset:CGPointMake(mTableView.contentOffset.x,commentsHeight+ 216+88) animated:YES];
    mTableView.scrollEnabled = NO;
}

-(void)hideKeyBoard
{
    NSLog(@"keyboard hides");
    //keybord hide
    mTableView.scrollEnabled = YES;
    if (!isEmojiPoped){
        [mTableView setContentOffset:CGPointMake(0, 366) animated:YES];
    }
}

-(void)hideEj
{
    mTableView.scrollEnabled = YES;
    isEmojiPoped = NO;
    
    NSLog(@"emoji hides");
    [UIView beginAnimations:@"hideEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [mTableView setContentOffset:CGPointMake(0, 366) animated:YES];
    [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
    [UIView commitAnimations];
}

-(void)showEj
{
    
    isEmojiPoped = YES;
    mTableView.scrollEnabled = YES;
    
    NSLog(@"emoji shows");
    [UIView beginAnimations:@"popEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [emojiView setFrame:CGRectMake(0, 480-EMOJI_HEIGHT-44-20, 320, EMOJI_HEIGHT)];
    [mTableView setContentOffset:CGPointMake(mTableView.contentOffset.x, commentsHeight+ EMOJI_HEIGHT+60) animated:YES];
    [UIView commitAnimations];
    
    mTableView.scrollEnabled = NO;
    
    //hide keyborad if keyboard showing
    [commentsText resignFirstResponder];
    
    
}

-(void)showEmotion
{
    if (!emojiView) {
        emojiView = [[EmojiView alloc] initWithFrame:CGRectMake(0, 480-20-44, 320, 134)];
        emojiView.delegate = self;
        [self.view addSubview:emojiView];
    }
    
    if (isEmojiPoped) {
        [self hideEj];
    }else{
        [self showEj];
    }
}

@end
