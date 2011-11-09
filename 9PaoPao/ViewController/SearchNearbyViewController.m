//
//  SearchNearbyViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011Âπ¥ __MyCompanyName__. All rights reserved.
//

#import "SearchNearbyViewController.h"
#import "PaoPaoCommon.h"

#define SearchBarHeight         40
#define SearchKindBtnWidth      89
#define SearchKindBtnHeight     29
#define SearchKindBtnPadding    2
#define SearchBarAndKindPadding 10
#define TableViewRowHeight      100

#define SearchKindWine          0
#define SearchKindPlace         1
#define SearchKindUser          2

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

    do{
        bounds = [[UIScreen mainScreen] bounds];

        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        containerView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
                
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
        mSearchBar.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
        
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
        
		[mSearchBar addSubview:mTextField];
        [containerView addSubview:mSearchBar];
        // ---------------searchbar-------------
        
        // ---------------search kind button-------------
        [self prepareSearchKindView];
        if (mSearchKindView) {
            [containerView addSubview:mSearchKindView];
        }
        // ---------------search kind button-------------
        
        // ---------------tableView-------------
        tableviewFrame.origin.x = bounds.origin.x;
		tableviewFrame.origin.y = bounds.origin.y + SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - (SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight);
		
        mTableView = [[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStyleGrouped];       
        mTableView.autoresizesSubviews = YES;
        mTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		mTableView.backgroundColor = [UIColor clearColor];
        
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        self.view = containerView;
        
        mWineResult = [[NSMutableArray alloc] initWithCapacity:0];
        
    }while (0);

}

- (void)prepareSearchKindView
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

    mSearchWineBtn = [PaoPaoCommon getImageButtonWithName:@"register.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchWineBtn.tag = SearchKindWine;
    mSearchWineBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;
    
    mSearchPlaceBtn = [PaoPaoCommon getImageButtonWithName:@"login.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchPlaceBtn.tag = SearchKindPlace;
    mSearchPlaceBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;

    mSearchUserBtn = [PaoPaoCommon getImageButtonWithName:@"login.png" highlightName:nil action:@selector(procSearchKindBtn:) target:self];
    mSearchUserBtn.tag = SearchKindUser;
    mSearchUserBtn.frame = CGRectMake(xPos, 0, SearchKindBtnWidth, SearchKindBtnHeight);
    xPos += SearchKindBtnWidth + SearchKindBtnPadding;

    [mSearchKindView addSubview:mSearchWineBtn];
    [mSearchKindView addSubview:mSearchPlaceBtn];
    [mSearchKindView addSubview:mSearchUserBtn];

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
	//return [mWineResult count];
    return 5;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UILabel *label = nil;
    UITableViewCell *cell = nil;
	
    do {
        // 処理
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            break_if(cell == nil);
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		//cell.layer.cornerRadius = 2;
		//cell.layer.borderColor = [EMColorWithRGB(129, 129, 129) CGColor];
		//cell.layer.borderWidth = 1;
        //cell.backgroundColor = [UIColor redColor];
        label = [cell textLabel];
        label.backgroundColor = [UIColor redColor];
        //[label setTextAlignment:UITextAlignmentCenter];
		//[label setTextColor:[UIColor blackColor]];
		//[label setFont:[UIFont fontWithName:@"Arial" size:17]];
        //[label setText:NSLocalizedString(@"AD No Group Info To Display", nil)];
		
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
	return TableViewRowHeight;
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
    rightItem = [[UIBarButtonItem alloc] initWithTitle:@"2公里" style:UIBarButtonItemStylePlain target:self action:@selector(procChooseRange:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
    mCurSearchKind = SearchKindWine;
    
    [leftItem release];
    leftItem = nil;
    
    [rightItem release];
    rightItem = nil;
    
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    
}

- (void)procChooseRange:(id)sender
{
    
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

    switch (button.tag) {
        case SearchKindWine:

            searchWineImage = [UIImage imageNamed:@""];
            searchPlaceImage = [UIImage imageNamed:@""];;
            searchUserImage = [UIImage imageNamed:@""];;
            self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
            break;
        case SearchKindPlace:
            
            searchWineImage = [UIImage imageNamed:@""];
            searchPlaceImage = [UIImage imageNamed:@""];;
            searchUserImage = [UIImage imageNamed:@""];;
            self.navigationItem.title = NSLocalizedString(@"SearchPlace Page Title", nil);
            break;
        case SearchKindUser:
            
            searchWineImage = [UIImage imageNamed:@""];
            searchPlaceImage = [UIImage imageNamed:@""];;
            searchUserImage = [UIImage imageNamed:@""];;
            self.navigationItem.title = NSLocalizedString(@"SearchUser Page Title", nil);
            break;
        default:
            break;
    }
//    [mSearchWineBtn setBackgroundImage:searchWineImage forState:UIControlStateNormal];
//    [mSearchPlaceBtn setBackgroundImage:searchPlaceImage forState:UIControlStateNormal];
//    [mSearchUserBtn setBackgroundImage:searchUserImage forState:UIControlStateNormal];

}
@end
