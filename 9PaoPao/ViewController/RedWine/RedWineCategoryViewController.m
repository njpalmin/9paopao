//
//  RedWineCategoryViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RedWineCategoryViewController.h"
#import "PaoPaoCommon.h"
#import "RedWineListViewController.h"

#define RedWineCategoryRowHeight        30
#define RedWineCategoryHeaderHeight     30

#define kRedWineCategoryNameKey         @"kRedWineCategoryNameKey"
#define kRedWineCatagoryContentKey      @"kRedWineCatagoryContentKey"

@implementation RedWineCategoryViewController

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
    if (mTableView) {
        [mTableView release];
        mTableView = nil;
    }
    
    if (mCategorys) {
        [mCategorys release];
        mCategorys = nil;
    }
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
        
        // ---------------tableView-------------
        tableviewFrame = bounds;
        
        mTableView = [[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStylePlain];       
        mTableView.autoresizesSubviews = YES;
        mTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		mTableView.backgroundColor = [UIColor clearColor];
		mTableView.separatorColor = [UIColor grayColor];
		
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        NSMutableDictionary    *dictionary = nil;
        
        dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setValue:@"色泽" forKey:kRedWineCategoryNameKey];
        [dictionary setValue:[NSArray arrayWithObjects:@"红葡萄酒", @"白葡萄酒", @"桃红酒", @"香槟", @"甜酒", nil] forKey:kRedWineCatagoryContentKey];

        mCategorys = [[NSMutableArray alloc] init];
        [mCategorys addObject:dictionary];
        [mCategorys addObject:dictionary];
        [mCategorys addObject:dictionary];

        [dictionary release];
        dictionary = nil;
        
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
    return [mCategorys count];
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return [[[mCategorys objectAtIndex:section] valueForKey:kRedWineCatagoryContentKey] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{			
    static NSString		*WineCellIdentifier = @"WineCell";
    UITableViewCell		*cell = nil;
    NSArray             *contentArray = nil;
    
    contentArray = [[mCategorys objectAtIndex:indexPath.section] valueForKey:kRedWineCatagoryContentKey];
    
    cell = [tableView dequeueReusableCellWithIdentifier:WineCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:WineCellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    
    UIImageView *backgroundView = nil;
    if (indexPath.row % 2) {
        //cell.backgroundColor = [UIColor lightGrayColor];
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey-bg.png"]] autorelease];
    }else{
        //cell.backgroundColor = [UIColor colorWithRed:190.0 green:190.0 blue:190.0 alpha:1.0];
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white-bg.png"]] autorelease];
    }
    backgroundView.frame = CGRectMake(-5, 0, 330, RedWineCategoryRowHeight);
    cell.backgroundView = backgroundView;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RedWineCategoryRowHeight;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	RedWineListViewController	*controller = nil;
	
	controller = [[RedWineListViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
	
	[controller release];
	controller = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return RedWineCategoryHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView          *headerView = nil;
    UIImageView     *imageView = nil;
    UILabel         *label = nil;
    
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, RedWineCategoryHeaderHeight)];

    imageView = [[[UIImageView alloc] initWithFrame:headerView.frame] autorelease];
    imageView.image = [UIImage imageNamed:@"header-bg.png"];
    [headerView addSubview:imageView];
    
    label = [[[UILabel alloc] initWithFrame:headerView.frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
	label.font = [UIFont fontWithName:PaoPaoFont size:16.0];
    label.text = [[mCategorys objectAtIndex:section] valueForKey:kRedWineCategoryNameKey];
    [headerView addSubview:label];

    return [headerView autorelease];
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
    
    [leftItem release];
    leftItem = nil;
    
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
	
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
