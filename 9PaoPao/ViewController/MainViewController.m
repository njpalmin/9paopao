//
//  MainViewController.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-8.
//  Copyright 2011年 MI2. All rights reserved.
//

#import "MainViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "MainViewCell.h"

@implementation MainViewController
@synthesize  _table;
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
    [imageNames release];
    [imageTitles release];
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
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton *backBtn =[[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    [backBtn setFrame:CGRectMake(5, 9, 60, 26)];
    [backBtn setTitle:@"Invite" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goToInvite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    [backBtn release];
    
    self.navigationItem.title = @"9 paopao";
    
    UIImageView *backgroundOfSearchBar=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bg.png"]];
    [backgroundOfSearchBar setFrame:CGRectMake(0, 0, 320, 44)];
    backgroundOfSearchBar.userInteractionEnabled = YES;
    
    UISearchBar *searchBar =[[UISearchBar alloc] initWithFrame:CGRectMake(0, 8, 320, 28)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.barStyle=UIBarStyleBlackTranslucent;
    searchBar.searchResultsButtonSelected = YES;
    searchBar.placeholder = @"输入葡萄酒、就把名称、地址等";
    searchBar.delegate = self;
    for (id cc in searchBar.subviews) {
        if ([cc isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [cc removeFromSuperview];
        }
    }
    [backgroundOfSearchBar addSubview:searchBar];
    [self.view addSubview:backgroundOfSearchBar];
    
    [backgroundOfSearchBar release];
    [searchBar release];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 400) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.scrollEnabled = NO;
    
    [self.view addSubview:_table];
    imageNames = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",
                                                                          @"first.png",nil]];
    
    imageTitles = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"热点地点",
                                                                           @"热门酒单",
                                                                           @"周围朋友",
                                                                           @"红酒区",
                                                                           @"啤酒区",
                                                                           @"鸡尾酒区",
                                                                           @"品酒打分器",
                                                                           @"最新活动",
                                                                           @"我的积分", nil] ];
    
//    viewControllers = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:[XXController class],
//                                                  @"热门酒单",
//                                                  @"周围朋友",
//                                                  @"红酒区",
//                                                  @"啤酒区",
//                                                  @"鸡尾酒区",
//                                                  @"品酒打分器",
//                                                  @"最新活动",
//                                                  @"我的积分", nil] ];

    
    position = 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"hello table");
    return 1;
}
#pragma mark Table view  delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MainViewCell *cell = [[MainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.delegate = self;
    for (int i = 0; i<3; i++) {
        position ++;
        if (position <= 9) {
            NSString *title = [imageTitles objectAtIndex:(position-1)];
            NSString *imageName = [imageNames objectAtIndex:(position-1)];
            [cell addButtonWithTitle:title andImageName:imageName andPosition:position andButtonTag:(i+1)];
        }
    }
    if (indexPath.row == 2) {
        position = 0;
    }
	return cell;	
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 118;
    }
	return 102;
	
}

-(void)clickButtonWithTag:(NSInteger)pos
{
    NSLog(@"click the position: %i",pos);
//    push the controller you need
//    Class *aClass = [viewControllers objectAtIndex:pos];
//    UIViewController *vCForPush = [[aClass alloc] init];
//    [self.navigationController pushViewController:vCForPush animated:YES];
}

-(void)goToInvite
{
    NSLog(@"invite");
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[_table reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
