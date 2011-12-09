//
//  BarDetailViewController.m
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BarDetailViewController.h"
#import "BarDetail.h"
#import "BarDetailCell.h"
#import "StarMarkView.h"
#import "PaoPaoCommon.h"
#import "ThumbMarkView.h"

#import "BarCommentDetailViewController.h"
#import "BarComment.h"
@implementation BarDetailViewController

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
		
#ifdef __IPHONE_5_0 
		if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
		{
			[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
		}
#endif 
        barArray = [[NSArray alloc] initWithArray:array];
        
    }
    return self;
}

- (void)dealloc
{
    if (barArray) {
        [barArray release];
        barArray = nil;
    }
    if (barTable) {
        [barTable release];
        barTable = nil;
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
    barTable = [[UITableView alloc] initWithFrame:view.frame style:UITableViewStyleGrouped];
    [view addSubview:barTable];
    barTable.delegate = self;
    barTable.dataSource = self;
    barTable.autoresizesSubviews = YES;
    barTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    barTable.backgroundColor = [UIColor clearColor];
    [view release];
    
    UIButton            *leftButton = nil;
    UIBarButtonItem     *leftItem = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:nil action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftItem release];
    leftItem = nil;

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
    return [barArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    BarDetailCell *cell = (BarDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = (BarDetailCell *)[[[BarDetailCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentify] autorelease];
        UIImage *bgImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar-icon-bg" ofType:@"png"]];
        cell.barImageView.image = bgImage;
        [bgImage release];
        
        
    }
    BarDetail *barObject = [barArray objectAtIndex:[indexPath section]];
    
    cell.barNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"barName: %@", nil), barObject.barName];
    cell.commentTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"commentTime: %@", nil), barObject.barCommentTime];
    cell.userNickNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"userNickname: %@", nil), barObject.userNickname];
    cell.commentMarkLabel.text = [NSString stringWithFormat:NSLocalizedString(@"commentMark: ", nil)];
    StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(0, 0, cell.markView.frame.size.width - 30, cell.markView.frame.size.height) withStarNum:3];
    [cell.markView addSubview:markView];
    
    
    ThumbMarkView	*thumbView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(markView.frame.origin.x + markView.frame.size.width, markView.frame.origin.y - 11, 30, markView.frame.size.height) withGoodNum:10 withBadNum:0];
    [cell.markView addSubview:thumbView];
    [thumbView release];
    [markView release];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BarComment *object = [[BarComment alloc] init];
    object.barName = @"名称：红酒吧";
    object.barLocation = @"地址：中国北关";
    object.barContact = @"联系信息：027－888888888";
    object.barCommentTimes = @"评论次数：15次";
    object.barCommentScore = @"4";
    BarCommentDetailViewController *vc = [[BarCommentDetailViewController alloc] initControllerWithBarCommentObject:object];
    [self.navigationController pushViewController:vc animated:YES];
    [object release];
    [vc release];
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
