//
//  AccountViewController.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-25.
//  Copyright 2011年 MI2. All rights reserved.
//
#define HEAD_HEIGHT  5.0
#define FOOT_HEIGHT  5.0
#define CELL_HEIGHT  40.0

#import "AccountViewController.h"
#import "MyProfileViewController.h"

#import "RegisterViewController.h"
#import "MyProfileViewController.h"
#import "SettingViewController.h"
#import "LoadHomePageViewController.h"
#import "TermViewController.h"
#import "PrivacyViewController.h"
#import "SignUpViewController.h"
#import "PaoPaoConstant.h"

@implementation AccountViewController

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
    [_table release];
    _table = nil;
    [imageArray release];
    imageArray = nil;
    [titleArray release];
    titleArray = nil;
    [viewControllers release];
    viewControllers = nil;
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
    self.navigationItem.title = @"我的账户";
    
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif
    
    CGRect bounds = [[UIScreen mainScreen] bounds];

    _table = [[UITableView alloc] initWithFrame:bounds style:UITableViewStyleGrouped];
    _table.contentSize = _table.frame.size;
    _table.delegate = self;
    _table.dataSource = self;
    
    [self.view addSubview:_table];
    
    imageArray = [[NSMutableArray alloc] initWithObjects:@"Accountlogin.png",@"AccountRegister.png",@"AccountMyprofile.png",@"AccountSetting.png",@"AccountSearch.png",@"AccountTerms.png",@"AccountPrivacy.png", nil];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"登录与登出",@"注册",@"我的资料",@"设置",@"访问9paopao.com",@"条款与备注",@"隐私权声明", nil];

    viewControllers = [[NSMutableArray alloc] initWithObjects:[SignUpViewController class],
                  [RegisterViewController class],
                  [MyProfileViewController class],
                  [SettingViewController class],
                  [LoadHomePageViewController class],
                  [TermViewController class],
                  [PrivacyViewController class], nil];
}


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
#pragma mark - UitableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 0) {
        return 1.0;
    }
    return HEAD_HEIGHT;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FOOT_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id class = [viewControllers objectAtIndex:indexPath.section];
    UIViewController *viewController = [[class alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
    viewController = nil;
}

#pragma mark -
#pragma mark - UitableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] init];
    if (section > 0) {
        [headView setFrame:CGRectMake(0, 0, 320, 1.0)];
    }else{
        [headView setFrame:CGRectMake(0, 0, 320, HEAD_HEIGHT)];
    }
    headView.backgroundColor = [UIColor clearColor];
    return [headView autorelease];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, FOOT_HEIGHT)];
    footView.backgroundColor = [UIColor clearColor];
    return [footView autorelease];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"accountIdentifier";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    NSString *imageName = [imageArray objectAtIndex:indexPath.section];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    NSString *title = [titleArray objectAtIndex:indexPath.section];
    cell.textLabel.text = title;
    
    cell.textLabel.font = [UIFont fontWithName:PaoPaoFont size:16];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    if ((indexPath.section +1 )%2 == 0) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}



@end
