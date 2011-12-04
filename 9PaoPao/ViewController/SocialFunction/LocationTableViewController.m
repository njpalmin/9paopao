//
//  LocationTableViewController.m
//  9PaoPao
//
//  Created by  on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationTableViewController.h"
#import "PaoPaoCommon.h"
#import "LocationDetail.h"

@implementation LocationTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithShowContentArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        showArray = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (void)dealloc
{
    if (searchBar) {
        [searchBar release];
        searchBar = nil;
    }
    if (locationTable) {
        [locationTable release];
        locationTable = nil;
    }
    if (showArray) {
        [showArray release];
        showArray = nil;
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
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = view;
    [view release];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    locationTable = [[UITableView alloc] initWithFrame:CGRectMake(0, searchBar.frame.origin.y + searchBar.frame.size.height, 320, self.view.frame.size.height - searchBar.frame.size.height) style:UITableViewStyleGrouped];
    locationTable.delegate = self;
    locationTable.dataSource = self;
    [self.view addSubview:locationTable];
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

#pragma mark ---------
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return TableViewSectionPadding;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TableViewSectionPadding;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, TableViewSectionPadding, TableViewSectionPadding)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark --------
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [showArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify] autorelease];
    }
    LocationDetail *object = (LocationDetail *)[showArray objectAtIndex:[indexPath section]];
    cell.textLabel.text = object.location;
    cell.detailTextLabel.text = object.detailLocation;
    return cell;
}



@end
