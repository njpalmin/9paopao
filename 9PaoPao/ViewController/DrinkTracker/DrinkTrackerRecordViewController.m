//
//  DrinkTrackerRecordViewController.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-22.
//  Copyright 2011年 MI2. All rights reserved.
//
#define EMOJI_HEIGHT 158
#define SEARECH_FAVORITE_WINE 101
#define SEARECH_FAVORITE_PLACE 102

#import "DrinkTrackerRecordViewController.h"
#import "PaoPaoCommon.h"
#import "WineDetailView.h"
#import "SearchManager.h"
#import "SearchCore.h"
#import "SearchManager.h"
#import "SearchCore.h"

@implementation DrinkTrackerRecordViewController

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
    [scoreView release];
    scoreView = nil;
    [toolBarView release];
    toolBarView = nil;
    [emojiView release];
    emojiView = nil;
    [commentsText release];
    commentsText = nil;
    [scrollView release];
    scrollView = nil;
    [placeBtn release];
    placeBtn = nil;
    
    [firstWineView release];
    firstWineView = nil;
    [secondImageView release];
    secondImageView = nil;
    
    [commentsLabel release];
    commentsLabel = nil;
    [scoreLabel release];
    scoreLabel = nil;
    [searchbar release];
    searchbar = nil;
    
    [sWinelabel release];
    sWinelabel = nil;
    [sPlacelabel release];
    sWinelabel = nil;
    [sPriceLabel release];
    sPlacelabel = nil;
    
    [_table release];
    _table = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height + 70);
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    [scrollView setBounces:YES];
    scrollView.userInteractionEnabled = YES;
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search-bg.png"]];
    
    [self.view addSubview:scrollView];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    leftItem = nil;
    
    self.navigationItem.title = @"品酒记录";
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    
    drinkBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    [drinkBtn setFrame:CGRectMake(3, 3, 314, 30)];
    [drinkBtn setTitle:@"你最喜欢喝什么酒" forState:UIControlStateNormal];
    drinkBtn.titleLabel.textAlignment = UITextAlignmentLeft;
    drinkBtn.tag = SEARECH_FAVORITE_WINE;
    [drinkBtn addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [drinkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scrollView addSubview:drinkBtn];
    
    placeBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    [placeBtn setFrame:CGRectMake(3, 37, 314, 30)];    
    [placeBtn setTitle:@"你最喜欢喝什么酒" forState:UIControlStateNormal];
    placeBtn.titleLabel.textAlignment = UITextAlignmentLeft;
    placeBtn.tag = SEARECH_FAVORITE_PLACE;
    [placeBtn addTarget:self action:@selector(clickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [placeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[placeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [scrollView addSubview:placeBtn];
    
    scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = @"评分";
    scoreLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:scoreLabel];
    
    scoreView = [[ScoreView alloc] init];
    [scrollView addSubview:scoreView];
    
    commentsLabel = [[UILabel alloc] init];
    commentsLabel.backgroundColor = [UIColor clearColor];
    commentsLabel.text = @"用户评论";
    [scrollView addSubview:commentsLabel];
    
    
    commentsText = [[UITextView alloc] init];
    commentsText.text = @"fhsajfsamflsamflsafmlsafslfmsfmlsmflasmfslmflsmflsamflsmflsf";
    commentsText.scrollEnabled = YES;
    commentsText.delegate = self;
    commentsText.backgroundColor = [UIColor clearColor];
    commentsText.contentInset = UIEdgeInsetsZero;
    [self addTooBarOnKeyboard];
    [scrollView addSubview:commentsText];
    
    toolBarView = [[ToolBarView alloc] init];
    toolBarView.delegate = self;
    [scrollView addSubview:toolBarView];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 460, 320, 460) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource =self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    searchWineResult = [[NSMutableArray alloc] initWithCapacity:0];
    
    //UITextView notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewKeyboardWillShow:) name:UITextViewTextDidBeginEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewKeyboardWillHide:) name:UITextViewTextDidEndEditingNotification object:nil];
    
    //UIKeyBoard notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    [self prepareCommentViewWithHeight:(placeBtn.frame.origin.y + placeBtn.frame.size.height)]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark - implement
-(void)drawWineViewWithDictionary:(NSMutableDictionary *)dic
{
    [self dismissSearchViewWithTag:SEARECH_FAVORITE_WINE];
    
    NSString *imageName = @"bar-icon-bg.png";
    NSString *wineName  = [dic objectForKey:@"name"];
    NSString *originePlace = [dic objectForKey:@"place"];
    NSString *price = [dic objectForKey:@"price"];
    if (!firstWineView) {
        firstWineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    firstWineView.frame = CGRectMake(3, 3, 74, 72);
    
    UILabel *winelabel = [[UILabel alloc] initWithFrame:CGRectMake(firstWineView.frame.origin.x+firstWineView.frame.size.width +20, firstWineView.frame.origin.y, 320 - (firstWineView.frame.origin.x+firstWineView.frame.size.width +20), firstWineView.frame.size.height/3)];
    [winelabel setTextColor:[UIColor blackColor]];
    [winelabel setFont:[UIFont systemFontOfSize:13.0]];
    [winelabel setBackgroundColor:[UIColor clearColor]];
    winelabel.text = wineName;
    
    UILabel *placelabel = [[UILabel alloc] initWithFrame:CGRectMake(winelabel.frame.origin.x, winelabel.frame.origin.y + winelabel.frame.size.height, 320 - winelabel.frame.origin.x, firstWineView.frame.size.height/3)];
    placelabel.textAlignment = UITextAlignmentLeft;
    [placelabel setTextColor:[UIColor blackColor]];
    [placelabel setFont:[UIFont systemFontOfSize:13.0]];
    [placelabel setBackgroundColor:[UIColor clearColor]];
    placelabel.text = originePlace;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(placelabel.frame.origin.x, placelabel.frame.origin.y + placelabel.frame.size.height, 320 - placelabel.frame.origin.x, firstWineView.frame.size.height/3)];
    priceLabel.textAlignment = UITextAlignmentLeft;
    [priceLabel setTextColor:[UIColor blackColor]];
    [priceLabel setFont:[UIFont systemFontOfSize:13.0]];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    priceLabel.text = price;
    
    [scrollView addSubview:winelabel];
    [scrollView addSubview:placelabel];
    [scrollView addSubview:priceLabel];
    [scrollView addSubview:firstWineView];
    
    CGFloat yOffset = firstWineView.frame.size.height - drinkBtn.frame.size.height;
    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, yOffset + scrollView.contentSize.height);
    
    if (drinkBtn) {
        [drinkBtn removeFromSuperview];
        [drinkBtn release];
        drinkBtn = nil;
    }
    
    [winelabel release];
    winelabel = nil;
    [placelabel release];
    winelabel = nil;
    [priceLabel release];
    placelabel = nil;
    
    if (placeBtn) {
        placeBtn.frame = CGRectOffset(placeBtn.frame, 0, yOffset);
        [self prepareCommentViewWithHeight:(placeBtn.frame.origin.y+placeBtn.frame.size.height)];
    }else if(secondImageView){        
        secondImageView.frame = CGRectOffset(secondImageView.frame, 0, yOffset);
        
        sWinelabel.frame = CGRectOffset(sWinelabel.frame, 0, yOffset);
        sPlacelabel.frame = CGRectOffset(sPlacelabel.frame, 0, yOffset);
        sPriceLabel.frame = CGRectOffset(sPriceLabel.frame, 0, yOffset);
        
        [self prepareCommentViewWithHeight:(secondImageView.frame.origin.y+secondImageView.frame.size.height)];
    }
    
}

-(void)drawPlaceViewWithDictionary:(NSMutableDictionary *)dic
{
    [self dismissSearchViewWithTag:SEARECH_FAVORITE_PLACE];
    
    NSString *imageName = @"bar-icon-bg.png";
    NSString *wineName  = [dic objectForKey:@"name"];
    NSString *originePlace = [dic objectForKey:@"place"];
    NSString *price = [dic objectForKey:@"price"];
    
    if (!secondImageView) {
        secondImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    }
    
    if (drinkBtn) {
        secondImageView.frame = CGRectMake(3,drinkBtn.frame.origin.y+drinkBtn.frame.size.height+ 3, 74, 72);
    }else if(firstWineView){
        secondImageView.frame = CGRectMake(3,firstWineView.frame.origin.y+firstWineView.frame.size.height+ 3, 74, 72);
    }
    
    sWinelabel = [[UILabel alloc] initWithFrame:CGRectMake(secondImageView.frame.origin.x+secondImageView.frame.size.width +20, secondImageView.frame.origin.y, 320 - (secondImageView.frame.origin.x+secondImageView.frame.size.width +20), secondImageView.frame.size.height/3)];
    sWinelabel.textAlignment = UITextAlignmentLeft;
    [sWinelabel setTextColor:[UIColor blackColor]];
    [sWinelabel setFont:[UIFont systemFontOfSize:13.0]];
    [sWinelabel setBackgroundColor:[UIColor clearColor]];
    sWinelabel.text = wineName;
    
    sPlacelabel = [[UILabel alloc] initWithFrame:CGRectMake(sWinelabel.frame.origin.x, sWinelabel.frame.origin.y + sWinelabel.frame.size.height, 320 - sWinelabel.frame.origin.x, secondImageView.frame.size.height/3)];
    sPlacelabel.textAlignment = UITextAlignmentLeft;
    [sPlacelabel setTextColor:[UIColor blackColor]];
    [sPlacelabel setFont:[UIFont systemFontOfSize:13.0]];
    [sPlacelabel setBackgroundColor:[UIColor clearColor]];
    sPlacelabel.text = originePlace;
    
    sPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(sPlacelabel.frame.origin.x, sPlacelabel.frame.origin.y + sPlacelabel.frame.size.height, 320 - sPlacelabel.frame.origin.x, secondImageView.frame.size.height/3)];
    sPriceLabel.textAlignment = UITextAlignmentLeft;
    [sPriceLabel setTextColor:[UIColor blackColor]];
    [sPriceLabel setFont:[UIFont systemFontOfSize:13.0]];
    [sPriceLabel setBackgroundColor:[UIColor clearColor]];
    sPriceLabel.text = price;
    
    CGFloat yOffset = secondImageView.frame.size.height - placeBtn.frame.size.height;
    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, yOffset + scrollView.contentSize.height);
    
    if (placeBtn) {
        [placeBtn removeFromSuperview];
        [placeBtn release];
        placeBtn = nil;
    }
    [scrollView addSubview:sWinelabel];
    [scrollView addSubview:sPlacelabel];
    [scrollView addSubview:sPriceLabel];
    [scrollView addSubview:secondImageView];
    
    [self prepareCommentViewWithHeight:(secondImageView.frame.origin.y+secondImageView.frame.size.height)];
}

-(void)clickSearchButton:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self presentSearchViewWithTag:btn.tag];
}

-(void)presentSearchViewWithTag:(int)tag
{
    if (!searchbar) {
        searchbar = [[UISearchBar alloc] init];
    }
    searchbar.frame = CGRectMake(0, 460, 320, 40);
    searchbar.showsBookmarkButton = NO;
    searchbar.barStyle = UIBarStyleBlackOpaque;		
    searchbar.autoresizesSubviews = YES;
    searchbar.searchResultsButtonSelected = YES;
    searchbar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
    searchbar.delegate = self;
    
    _table.frame = CGRectMake(0, 460, 320, 306);

    [self.view addSubview:searchbar];
    
    if (tag == SEARECH_FAVORITE_WINE) {
        searchbar.tag = SEARECH_FAVORITE_WINE;
        searchbar.placeholder = @"输入葡萄酒名称";

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        searchbar.frame = CGRectMake(0, 460-296, 320, 40);
        _table.frame = CGRectMake(0, searchbar.frame.origin.y + searchbar.frame.size.height, 320, 306);
        [UIView commitAnimations];
    }
    if (tag == SEARECH_FAVORITE_PLACE) {
        searchbar.tag = SEARECH_FAVORITE_PLACE;
        searchbar.placeholder = @"输入酒吧名称";

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        searchbar.frame = CGRectMake(0, 460-296, 320, 40);
        _table.frame = CGRectMake(0, searchbar.frame.origin.y + searchbar.frame.size.height, 320, 306);
        [UIView commitAnimations];
    }
    
    if (!touchView) {
        touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-216-44-50)];
        touchView.backgroundColor = [UIColor clearColor];
        touchView.userInteractionEnabled = YES;
        [self.view addSubview:touchView];
    }
}

-(void)dismissSearchViewWithTag:(int)tag
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    searchbar.frame = CGRectMake(0, 460, 320, 40);
    _table.frame = CGRectMake(0, searchbar.frame.origin.y + searchbar.frame.size.height, 320, 306);
    [UIView commitAnimations];    
}

-(void)prepareCommentViewWithHeight:(CGFloat)yPosition
{
    yHeight = yPosition;
    
    [scoreLabel setFrame:CGRectMake(12, yPosition+14, 50, 18)];
    [scoreView setFrame:CGRectMake(60, yPosition+28, 196, 187)];
    [commentsLabel setFrame:CGRectMake(12, yPosition+221, 140, 18)];
    [commentsText setFrame:CGRectMake(40, yPosition+243, 240, 90)];
    [toolBarView setFrame:CGRectMake(0, yPosition+333, 320, 30)];
}

-(void)addTooBarOnKeyboard
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 480-216, 320, 30)];  
    [topView setBarStyle:UIBarStyleBlack];  
    
    //UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];  
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];  
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];  
    [doneButton release];  
    [btnSpace release];  
    
    [topView setItems:buttonsArray];  
    [commentsText setInputAccessoryView:topView];  
}

-(void)dismissKeyBoard  
{  
    [commentsText resignFirstResponder];  
} 

-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)startSearching
{
    SearchManager   *defaultManager= [SearchManager defaultSearchManager];
    defaultManager.delegate = self;
    
    NSString *keyWord = searchbar.text;
    
    if (searchbar.tag == SEARECH_FAVORITE_WINE) {
        defaultManager.searchType = SearchType_WineList;
        [defaultManager startSearchWithKeyword:keyWord withType:SearchType_WineList withPage:2];
    }
    if (searchbar.tag == SEARECH_FAVORITE_PLACE) {
        defaultManager.searchType = SearchType_WineryList;
    }
    
}
#pragma mark -
#pragma mark SearchManagerDelegate
- (void)searchManagerDidFinish:(SearchManager *)manager
{
    SearchManager   *defaultManager = nil;
    defaultManager= [SearchManager defaultSearchManager];
        
    if (searchbar.tag == SEARECH_FAVORITE_WINE) {
        if (defaultManager.searchType == SearchType_WineList) {
            [searchWineResult removeAllObjects];
            [searchWineResult addObjectsFromArray:defaultManager.wineListResults];
        }
    }
    else if (searchbar.tag == SEARECH_FAVORITE_PLACE)
    {
        defaultManager.searchType = SearchType_WineryList;
    }
    
    [_table reloadData];
}

- (void)searchManager:(SearchManager *)manager didFailWithError:(NSError*)error
{
    
}

#pragma mark - UIKeyBoard notification
-(void)keyboardWillShow:(NSNotification *)noti
{
    isKeyBoardUp = YES;
}

-(void)keyboardWillHide:(NSNotification *)noti
{
    isKeyBoardUp = NO;
}

#pragma mark - UITextView notification
- (void)textViewKeyboardWillShow:(NSNotification *)noti
{
    [self showKeyBoard];
}

- (void)textViewKeyboardWillHide:(NSNotification *)noti
{
    [self hideKeyBoard];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchbar.tag == SEARECH_FAVORITE_WINE && [searchWineResult count] > 0) {
		
		static NSString		*wineCellIdentifier = @"WineCell";
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:wineCellIdentifier];
		if (cell == nil)
		{
			cell = [[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wineCellIdentifier];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		[cell setWineDetailRecord:[searchWineResult objectAtIndex:indexPath.section]];
		
		return cell;
	}
	else if (searchbar.tag == SEARECH_FAVORITE_PLACE && [searchPlaceResult count] > 0)
	{
		static NSString		*placeCellIdentifier = @"PlaceCell";
		// temp test 
		WineDetailView		*cell = nil;
		
		cell = (WineDetailView*)[tableView dequeueReusableCellWithIdentifier:placeCellIdentifier];
		if (cell == nil)
		{
			cell = [[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeCellIdentifier];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		[cell setPlaceDetailRecord];
		
		return cell;
	}
    
    static NSString *identifier = @"drinkTrackerIdentifier";
    WineDetailView *cell = nil;
    
    cell = (WineDetailView *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[WineDetailView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setPlaceDetailRecord];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchbar.tag == SEARECH_FAVORITE_WINE) {
        WineDetailView *cell = (WineDetailView *)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *values = [NSArray arrayWithObjects:cell.mWineKind.text,cell.mWineName.text,cell.mWinePrice.text,cell.mWineProductDay.text,cell.mWineProductPlace.text, nil];
        NSArray *keys = [NSArray arrayWithObjects:@"kind",@"name",@"price",@"day",@"place", nil];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
        [self drawWineViewWithDictionary:dic];
        return;
    }
    if (searchbar.tag == SEARECH_FAVORITE_PLACE) {
        WineDetailView *cell = (WineDetailView *)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *values = [NSArray arrayWithObjects:cell.mWineKind.text,cell.mWineName.text,cell.mWinePrice.text,cell.mWineProductDay.text,cell.mWineProductPlace.text, nil];
        NSArray *keys = [NSArray arrayWithObjects:@"kind",@"name",@"price",@"day",@"place", nil];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
        [self drawPlaceViewWithDictionary:dic];
        return;
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)sBar// called when text starts editing
{
    if (!touchView) {
        touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-216-44-50)];
        touchView.backgroundColor = [UIColor clearColor];
        touchView.userInteractionEnabled = YES;
        [self.view addSubview:touchView];
    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar// called when text ends editing
{

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar// called when keyboard search button pressed
{
    [sBar resignFirstResponder];
    [self startSearching];
}

#pragma mark -
#pragma mark UITouch envent
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([searchbar isFirstResponder]) {
        [searchbar resignFirstResponder];
    }else if (touchView){
        [self dismissSearchViewWithTag:SEARECH_FAVORITE_WINE];
        [self dismissSearchViewWithTag:SEARECH_FAVORITE_PLACE];
        [touchView removeFromSuperview];
        [touchView release];
        touchView = nil;
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
}

#pragma mark -
#pragma mark LocationManagerDelegate

- (void)locationManagerUpdateHeading:(LocationManager*)controller
{
	CLLocation	*location = nil;
	
	location = controller.newLocation;
}

- (void)locationManager:(LocationManager*)controller didReceiveError:(NSError*)error
{
	
}

#pragma mark -  EmojiViewDelegate
-(void)showEmojiInMessage:(NSString *)text
{
    commentsText.text = [commentsText.text stringByAppendingString:text];
}

#pragma mark -  ToolBarViewDelegate
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
    scrollView.scrollEnabled = YES;
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, yHeight+ 216-20) animated:YES];
    
    //emojiview hide if poped
    if (isEmojiPoped) {
        NSLog(@"emoji hide in keyboard show ");
        scrollView.scrollEnabled = NO;
        
        [UIView beginAnimations:@"hideEmojiView" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
        [UIView commitAnimations];
        
        isEmojiPoped = NO;
    }
    
    scrollView.scrollEnabled = NO;
}
-(void)hideKeyBoard
{
    NSLog(@"keyboard hides");
    //keybord hide
    scrollView.scrollEnabled = YES;
    if (!isEmojiPoped){
        [scrollView setContentOffset:CGPointMake(0, 70) animated:YES];
    }
}

-(void)hideEj
{
    scrollView.scrollEnabled = YES;
    isEmojiPoped = NO;
    
    NSLog(@"emoji hides");
    [UIView beginAnimations:@"hideEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [scrollView setContentOffset:CGPointMake(0 ,70) animated:YES];
    [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
    [UIView commitAnimations];
}

-(void)showEj
{
    
    isEmojiPoped = YES;
    //hide keyborad if keyboard showing
    [commentsText resignFirstResponder];
    
    scrollView.scrollEnabled = YES;
    
    NSLog(@"emoji shows");
    [UIView beginAnimations:@"popEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [emojiView setFrame:CGRectMake(0, 480-EMOJI_HEIGHT-44-20, 320, EMOJI_HEIGHT)];
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, yHeight+ EMOJI_HEIGHT - 50) animated:YES];
    [UIView commitAnimations];
    
    scrollView.scrollEnabled = NO;
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
