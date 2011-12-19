//
//  CurrentLatestOfferViewController.m
//  9PaoPao
//
//  Created by  on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrentLatestOfferViewController.h"
#import "LatestOfferObject.h"
#import "MapViewController.h"
#import "ThumbMarkView.h"
#import "StarMarkView.h"
#import "PaoPaoCommon.h"
@implementation CurrentLatestOfferViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initControllerWithCurrentLatestOffer:(LatestOfferObject *)object
{
    self = [super init];
    if (self) {
		
        currentLatestOfferTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        currentLatestOfferTableView.delegate = self;
        currentLatestOfferTableView.dataSource = self;
        currentLatestOffer = [object retain];
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
        
        
        UILabel *inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(barImageView.frame.origin.x + barImageView.frame.size.width, barImageView.frame.origin.y, 180, 14)];
        [inforLabel setFont:[UIFont systemFontOfSize:13.0]];
        [inforLabel setBackgroundColor:[UIColor clearColor]];
        inforLabel.text = @"特别促销信息：";
        [cell.contentView addSubview:inforLabel];
        
        
        UILabel *latestOfferInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(inforLabel.frame.origin.x, inforLabel.frame.origin.y + inforLabel.frame.size.height + 1, inforLabel.frame.size.width, 14)];
        [latestOfferInfoLabel setFont:[UIFont systemFontOfSize:13.0]];
        [latestOfferInfoLabel setBackgroundColor:[UIColor clearColor]];
        latestOfferInfoLabel.text = @"blah";
        [cell.contentView addSubview:latestOfferInfoLabel];
        [latestOfferInfoLabel release];
        
                
        StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(41, barImageView.frame.origin.y + barImageView.frame.size.height + 2, cell.contentView.frame.size.width - 30, 30) withStarNum:4];
        [cell.contentView addSubview:markView];
        
        
        ThumbMarkView	*thumbView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(markView.frame.origin.x + markView.frame.size.width, markView.frame.origin.y - 11, 30, markView.frame.size.height) withGoodNum:10 withBadNum:0];
        [cell.contentView addSubview:thumbView];
        [thumbView release];
        [markView release];
        [barImageView release];
        
                
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
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    self.view = view;
    [self.view addSubview:currentLatestOfferTableView];
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
    [currentLatestOfferTableView release];
    [currentLatestOffer release];
    [mVC release];
    [super dealloc];
}

@end
