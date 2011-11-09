//
//  SearchNearbyViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchNearbyViewController.h"
#import "PaoPaoCommon.h"

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
    CGRect          searchBarframe, bounds, tableviewFrame, buttonFrame;
    UIView          *containerView = nil;
    UITableView     *tableView = nil;

    do{
        bounds = [[UIScreen mainScreen] bounds];

        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        containerView.backgroundColor = [UIColor whiteColor];
                
        break_if(![self prepareNavigationBar]);
        
        // ---------------searchbar-------------
        searchBarframe.origin.x = bounds.origin.x;
        searchBarframe.origin.y = 0;
        searchBarframe.size.width = bounds.size.width;
        searchBarframe.size.height = 40.0;
        
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
        
        buttonFrame.origin.x = bounds.origin.x;
		buttonFrame.origin.y = bounds.origin.y + 40;
		buttonFrame.size.width = bounds.size.width;
		buttonFrame.size.height = bounds.size.height - 40;
         
       // mSearchWineBtn = [PaoPaoCommon getBarButtonWithTitle:<#(NSString *)#> imageName:<#(NSString *)#> highlightedImageName:<#(NSString *)#> action:<#(SEL)#> target:<#(id)#>];
        UIButton        *mSearchPlaceBtn;
        UIButton        *mSearchUserBtn;
        // ---------------search kind button-------------
        
        // ---------------tableView-------------
    
        tableviewFrame.origin.x = bounds.origin.x;
		tableviewFrame.origin.y = bounds.origin.y + 40;
		tableviewFrame.size.width = bounds.size.width;
		tableviewFrame.size.height = bounds.size.height - 40;
		
//		if ((START_CITY == mPickerType) || (DESTINATION_CITY == mPickerType) || (TICKET_DELIVERY_CITY == mPickerType)) {
//			tableView = [[[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStyleGrouped] autorelease];
//		}else {
//			tableView = [[[UITableView alloc] initWithFrame:bounds style:UITableViewStyleGrouped] autorelease];
//		}
//        
//        break_if(tableView == nil);
//        
//        tableView.autoresizesSubviews = YES;
//        tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//		
//		mTableView = [tableView retain];
//        [containerView addSubview:tableView];
//        mTableView.delegate=self;
//		mTableView.dataSource=self;
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

@end
