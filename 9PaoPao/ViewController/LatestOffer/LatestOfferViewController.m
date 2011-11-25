//
//  LatestOfferViewController.m
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LatestOfferViewController.h"
#import "PaoPaoCommon.h"
#import "LatestOfferObject.h"
#import "LatestOfferViewCell.h"
@implementation LatestOfferViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initControllerWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        latestOfferArray = [[NSArray alloc] initWithArray:array];
    }
    return self;
}

- (void)dealloc
{
    if (latestOfferArray) {
        [latestOfferArray release];
        latestOfferArray = nil;
    }
    if (latestOfferTable) {
        [latestOfferArray release];
        latestOfferTable = nil;
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.view = view;
    latestOfferTable = [[UITableView alloc] initWithFrame:view.frame style:UITableViewStyleGrouped];
    [view addSubview:latestOfferTable];
    latestOfferTable.delegate = self;
    latestOfferTable.dataSource = self;
    latestOfferTable.autoresizesSubviews = YES;
    latestOfferTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    latestOfferTable.backgroundColor = [UIColor clearColor];
    [view release];

#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
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

#pragma mark --------
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [latestOfferArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    LatestOfferViewCell *cell = (LatestOfferViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = (LatestOfferViewCell *)[[[LatestOfferViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentify] autorelease];
        UIImage *bgImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar-icon-bg" ofType:@"png"]];
        cell.latestOfferImageView.image = bgImage;
        [bgImage release];
        
        UIImage *accessImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"right-arrow" ofType:@"png"]];
        UIImageView *accessView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, accessImage.size.width, accessImage.size.height)];
        accessView.image = accessImage;
        cell.accessoryView = accessView;
        [accessImage release];
        [accessView release];
        
        
    }
    


    LatestOfferObject *object = [latestOfferArray objectAtIndex:[indexPath section]];
    cell.latestOfferLocationLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latestOfferTitle", nil),object.latestOfferTitle];
    cell.latestOfferLocationLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latestOfferLocation:%@ ", nil),object.latestOfferLocation];
    cell.latestOfferHostLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latestOfferHost:%@", nil),object.latestOfferHost];
    cell.latestOfferCommentLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latestOfferComment:%@", nil),object.latestOfferComment];
    return cell;
}

#pragma mark -------
#pragma mark UITableViewDelegate
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

@end
