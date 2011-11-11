//
//  SearchNearbyViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011Âπ¥ __MyCompanyName__. All rights reserved.
//

#import "SearchNearbyViewController.h"
#import "StarMarkView.h"
#import "PaoPaoCommon.h"

#define SearchKindBtnWidth          89
#define SearchKindBtnHeight         29
#define SearchKindBtnPadding        2
#define SearchBarAndKindPadding     10

#define SearchKindWine              0
#define SearchKindPlace             1
#define SearchKindUser              2

#define CellLeftImageTag            1000

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
		tableviewFrame.origin.y = bounds.origin.y + SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight + SearchKindAndTablePadding;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - (SearchBarHeight + SearchBarAndKindPadding + SearchKindBtnHeight + SearchKindAndTablePadding);
		
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
        mRangeArray = [[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], 
                       [NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:20], nil] retain];
        
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
        
        [[cell.contentView viewWithTag:CellLeftImageTag] removeFromSuperview];
        
        UIImage     *image = nil;
        UIImageView *leftImageView = nil;
        
        image = [UIImage imageNamed:@"bar-icon-bg.png"];
        leftImageView = [[UIImageView alloc] initWithImage:image];
        leftImageView.frame = CGRectMake(8, 10, image.size.width, image.size.height);
        leftImageView.tag = CellLeftImageTag;
        
        [cell.contentView addSubview:leftImageView];
        
        [leftImageView release];
        leftImageView = nil;
        
        StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(90, 70, 0, 0) withStarNum:3];
        [cell.contentView addSubview:markView];
        
		
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
#pragma mark DeviceISCSIPortPropertyViewControllerDelegate

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

    switch (button.tag) {
        case SearchKindWine:

            searchWineImage = [UIImage imageNamed:@"search-alcohol-selected.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchNearby Page Title", nil);
            break;
        case SearchKindPlace:
            
            searchWineImage = [UIImage imageNamed:@"search-alcohol.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place-selected.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchPlace Page Title", nil);
            break;
        case SearchKindUser:
            
            searchWineImage = [UIImage imageNamed:@"search-alcohol.png"];
            searchPlaceImage = [UIImage imageNamed:@"search-place.png"];;
            searchUserImage = [UIImage imageNamed:@"search-friends-selected.png"];;
            self.navigationItem.title = NSLocalizedString(@"SearchUser Page Title", nil);
            break;
        default:
            break;
    }
    [mSearchWineBtn setBackgroundImage:searchWineImage forState:UIControlStateNormal];
    [mSearchPlaceBtn setBackgroundImage:searchPlaceImage forState:UIControlStateNormal];
    [mSearchUserBtn setBackgroundImage:searchUserImage forState:UIControlStateNormal];

}
@end
