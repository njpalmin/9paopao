//
//  DrinkWineRecordViewController.m
//  9PaoPao
//
//  Created by  on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DrinkWineRecordViewController.h"
#import "CoreLocationService.h"
#import "MapViewController.h"

@implementation DrinkWineRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFood:(NSString *)food
{
    self = [super init];
    if (self) {
        withFood = [food retain];
        insertArray = [[NSMutableArray alloc] init];
    }
    return self;
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 376)];
    drinkWineTableView = [[UITableView alloc] initWithFrame:view.frame];
    drinkWineTableView.delegate = self;
    drinkWineTableView.dataSource = self;
    [view addSubview:drinkWineTableView];
    self.view = view;
    [view release];
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

- (void)dealloc
{
    if (withFood) {
        [withFood release];
        withFood = nil;
    }
    if (toolBar) {
        toolBar.delegate = nil;
        [toolBar release];
        toolBar = nil;
    }
    [super dealloc];
}

#pragma mark ---------
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 30;
    }else 
    {
        return 50;
    }
}

#pragma mark -------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = [insertArray count] + 2;
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if ([indexPath row ] == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = withFood;
        [cell.contentView addSubview:label];
        [label release];
    }else if([indexPath row] == 1 )
    {
        toolBar = [[ToolBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        toolBar.delegate = self;
        [cell.contentView addSubview:toolBar];
    }else if([indexPath row] == 2)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"中西远";
        [cell.contentView addSubview:label];
        [label release];

    }
    return cell;
}

#pragma mark ------
#pragma mark ToolBarViewDelegate
- (void)locateMySelf
{
    if (![[CoreLocationService shareLocationService] locationServiceEnabled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"本机的定位服务不可用" message:@"您无法启用设备上的定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }else
    {
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:3 inSection:0];
        [insertArray addObject:indexPath1];
        [insertArray addObject:indexPath2];
        [drinkWineTableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

@end
