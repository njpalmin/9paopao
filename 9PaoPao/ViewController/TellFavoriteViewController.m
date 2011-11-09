//
//  TellFavoriteViewController.m
//  9PaoPao
//
//  Created by quanhong ma on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TellFavoriteViewController.h"


@implementation TellFavoriteViewController
@synthesize titleLabel;
@synthesize favoriteTable;
@synthesize navTitle;
@synthesize contentArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithContentDic:(NSArray *)array
{
    self = [super init];
    if (self) {
        contentArray = [[NSArray alloc] initWithArray:array];
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release];
    [favoriteTable release];
    [navTitle release];
    [contentArray release];
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
    float width = [[UIScreen  mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.view = view;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    titleLabel.text = navTitle;
    [self.view addSubview:titleLabel];
    favoriteTable = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, width, height - titleLabel.frame.size.height - 44)];
    favoriteTable.delegate = self;
    favoriteTable.dataSource = self;
    [self.view addSubview:favoriteTable];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel = titleLabel;
    self.favoriteTable = favoriteTable;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.titleLabel = nil;
    self.favoriteTable = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark --------
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [contentArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [contentArray objectAtIndex:section];
    NSArray *keyArray = [dic allKeys];
    return [keyArray objectAtIndex:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [contentArray objectAtIndex:section];
    NSArray *keyArray = [dic allKeys];
    NSString *key = [keyArray objectAtIndex:0];
    NSArray *array = [dic objectForKey:key];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    NSDictionary *dic = [contentArray objectAtIndex:[indexPath section]];
    NSArray *keyArray = [dic allKeys];
    NSString *key = [keyArray objectAtIndex:0];
    NSArray *array = [dic objectForKey:key];
    cell.textLabel.text = [array objectAtIndex:[indexPath row]];
    return cell;
}

#pragma mark =======
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
