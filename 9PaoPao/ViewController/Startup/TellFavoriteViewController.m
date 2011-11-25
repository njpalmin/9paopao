//
//  TellFavoriteViewController.m
//  9PaoPao
//
//  Created by quanhong ma on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TellFavoriteViewController.h"
#import "PaoPaoConstant.h"

@implementation TellFavoriteViewController
@synthesize titleLabel;
@synthesize favoriteTable;
@synthesize navTitle;
@synthesize contentArray;
@synthesize delegate = mDelegate;

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
    float height = [[UIScreen mainScreen] bounds].size.height - 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.view = view;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 60)];
    titleLabel.text = navTitle;
	titleLabel.font = [UIFont fontWithName:PaoPaoFont size:16.0];
    self.title = @"9paopao";
    [self.view addSubview:titleLabel];
    favoriteTable = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, width, height - titleLabel.frame.size.height)];
    favoriteTable.delegate = self;
    favoriteTable.dataSource = self;
    [self.view addSubview:favoriteTable];
    self.titleLabel.text =  @"告诉9泡泡，我最喜欢...";
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setFrame:CGRectMake(5, 9, 60, 26)];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(procFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(procFinishBtn:)];

    self.navigationItem.rightBarButtonItem = rItem;
    self.navigationItem.leftBarButtonItem = nil;
    [rItem release];
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
    return nil;
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
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    NSDictionary *dic = [contentArray objectAtIndex:[indexPath section]];
    NSArray *keyArray = [dic allKeys];
    NSString *key = [keyArray objectAtIndex:0];
    NSArray *array = [dic objectForKey:key];
    if ([indexPath section] == 0) {
        UIImage *beerImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"beer" ofType:@"png"]];
        cell.imageView.image = beerImage;
        [beerImage release];
    }else if([indexPath section] == 1)
    {
        UIImage *cocktailImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"png"]];
        cell.imageView.image = cocktailImage;
        [cocktailImage release];
    }else if([indexPath section] == 2)
    {
        UIImage *beerImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"beer" ofType:@"png"]];
        cell.imageView.image = beerImage;
        [beerImage release];
    }
    
    if ([indexPath row] %2 == 0) {
        UIImage *bgImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pink-bg" ofType:@"png"]];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, bgImage.size.width, bgImage.size.height)];
        bgImageView.image = bgImage;
        cell.backgroundView = bgImageView;
        [bgImage release];
        [bgImageView release];
    }else
    {
        UIImage *bgImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gray-bg" ofType:@"png"]];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, bgImage.size.width, bgImage.size.height)];
        bgImageView.image = bgImage;
        cell.backgroundView = bgImageView;
        [bgImage release];
        [bgImageView release];
    }
    UIImage *accessImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"right-arrow" ofType:@"png"]];
    UIImageView *accessView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, accessImage.size.width, accessImage.size.height)];
    accessView.image = accessImage;
    cell.accessoryView = accessView;
    [accessImage release];
    [accessView release];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [array objectAtIndex:[indexPath row]];
	cell.textLabel.font = [UIFont fontWithName:PaoPaoFont size:16.0];
    return cell;
}

#pragma mark =======
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UIImage *bgImage =  [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"header-bg" ofType:@"png"]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    imageView.image = bgImage;
    [view addSubview:imageView];
    [bgImage release];
    [imageView release];
    
    NSDictionary *dic = [contentArray objectAtIndex:section];
    NSArray *keyArray = [dic allKeys];
    UILabel *tabel = [[UILabel alloc] initWithFrame:view.frame];
    tabel.backgroundColor = [UIColor clearColor];
	tabel.font = [UIFont fontWithName:PaoPaoFont size:17.0];
    tabel.text = [keyArray objectAtIndex:0];
    [view addSubview:tabel];
    [tabel release];
    return [view autorelease];
}

#pragma mark －
#pragma mark Action

- (void)procFinishBtn:(id)sender
{
    [mDelegate tellFavoriteViewControllerDidFinish:self];
}

@end
