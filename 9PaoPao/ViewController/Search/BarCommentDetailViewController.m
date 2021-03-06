//
//  BarCommentDetailViewController.m
//  9PaoPao
//
//  Created by  on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BarCommentDetailViewController.h"
#import "BarComment.h"
#import "ThumbMarkView.h"
#import "StarMarkView.h"
#import "MapViewController.h"
#import "PaoPaoCommon.h"
#import "DrinkWineRecordViewController.h"

@implementation BarCommentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initControllerWithBarCommentObject:(BarComment *)object
{
    self = [super init];
    if (self) {
		
#ifdef __IPHONE_5_0 
		if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
		{
			[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
		}
#endif 
        barCommentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        barCommentTableView.delegate = self;
        barCommentTableView.dataSource = self;
        commentObject = [object retain];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -------
#pragma mark UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        
    }
    if ([indexPath row] == 0) {
        UIImage *barIcon = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar-icon-bg" ofType:@"png"]];
        UIImageView *barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, barIcon.size.width , barIcon.size.height)];
        barImageView.image = barIcon;
        [barIcon release];
        [cell.contentView addSubview:barImageView];
       
        
        UILabel *barNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(barImageView.frame.origin.x + barImageView.frame.size.width, barImageView.frame.origin.y, 180, 14)];
        [barNameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [barNameLabel setBackgroundColor:[UIColor clearColor]];
        barNameLabel.text = commentObject.barName;
        [cell.contentView addSubview:barNameLabel];
        
        
        UILabel *barLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, barNameLabel.frame.origin.y + barNameLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [barLocationLabel setFont:[UIFont systemFontOfSize:13.0]];
        [barLocationLabel setBackgroundColor:[UIColor clearColor]];
        barLocationLabel.text = commentObject.barLocation;
        [cell.contentView addSubview:barLocationLabel];
        [barLocationLabel release];
        
        UILabel *barContaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, barLocationLabel.frame.origin.y + barLocationLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [barContaceLabel setFont:[UIFont systemFontOfSize:13.0]];
        [barContaceLabel setBackgroundColor:[UIColor clearColor]];
        barContaceLabel.text = commentObject.barContact;
        [cell.contentView addSubview:barContaceLabel];
        
        
        UILabel *commentTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, barContaceLabel.frame.origin.y + barContaceLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [commentTimesLabel setFont:[UIFont systemFontOfSize:13.0]];
        [commentTimesLabel setBackgroundColor:[UIColor clearColor]];
        commentTimesLabel.text = commentObject.barCommentTimes;
        [cell.contentView addSubview:commentTimesLabel];
        [commentTimesLabel release];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, barImageView.frame.origin.y + barImageView.frame.size.height + 2, 40, 14)];
        [scoreLabel setFont:[UIFont systemFontOfSize:13.0]];
        [scoreLabel setBackgroundColor:[UIColor clearColor]];
        scoreLabel.text = @"评分：";
        [cell.contentView addSubview:scoreLabel];
        [scoreLabel release];
        
        StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(41, barImageView.frame.origin.y + barImageView.frame.size.height + 2, cell.contentView.frame.size.width - 30, 30) withStarNum:4];
        [cell.contentView addSubview:markView];
        
        
        ThumbMarkView	*thumbView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(markView.frame.origin.x + markView.frame.size.width, markView.frame.origin.y - 11, 30, markView.frame.size.height) withGoodNum:10 withBadNum:0];
        [cell.contentView addSubview:thumbView];
        [thumbView release];
        [markView release];
         [barImageView release];
    
        UIButton *focus = [UIButton buttonWithType:UIButtonTypeCustom];
        //[focus setTitle:@"关注" forState:UIControlStateNormal];
        [focus setBackgroundImage:[UIImage imageNamed:@"follow-button.png"] forState:UIControlStateNormal];
        [focus addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        focus.frame = CGRectMake(barContaceLabel.frame.origin.x + barContaceLabel.frame.size.width, barContaceLabel.frame.origin.y, 50, 30);
        //cell.accessoryView = focus;
        [cell.contentView addSubview:focus];
       
        [barContaceLabel release];
        [barNameLabel release];

    }else if([indexPath row] == 1)
    {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        titleLabel.text = @"用户评论：";
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        
        UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 30)];
        commentLabel.text = @"blnh,blanh";
        [cell.contentView addSubview:commentLabel];
        [commentLabel release];
    }else if([indexPath row] == 2)
    {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        titleLabel.text = @"特别推荐及活动";
        [cell.contentView addSubview:titleLabel];
       
        
        mVC = [[MapViewController alloc] init];
        mVC.view.frame = CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height, 320, 160);
        [cell.contentView addSubview:mVC.view];
        [titleLabel release];
    }
    
    
    return cell;
}

#pragma mark --------
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 120;
    }else if([indexPath row] == 1)
    {
        return 70;
    }else 
    {
        return 200;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DrinkWineRecordViewController *dVC = [[DrinkWineRecordViewController alloc] initWithFood:@"鸡肉，梨子派"];
    [self.navigationController pushViewController:dVC animated:YES];
    [dVC release];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    self.view = view;
    [self.view addSubview:barCommentTableView];
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

- (void)focus:(id)sender
{}

- (void)dealloc
{
    [barCommentTableView release];
    [commentObject release];
     [mVC release];
    [super dealloc];
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
