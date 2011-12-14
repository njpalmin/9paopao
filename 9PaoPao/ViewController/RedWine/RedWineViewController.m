//
//  RedWineViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RedWineViewController.h"
#import "PaoPaoCommon.h"
#import "RedWineCategoryViewController.h"
#import "RedWineListViewController.h"

#define RedWineCategoryRowHeight    30

@implementation RedWineViewController

- (void)dealloc
{
    if (mTableView) {
        [mTableView release];
        mTableView = nil;
    }
    
    if (mCategorys) {
        [mCategorys release];
        mCategorys = nil;
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
    CGRect          bounds, tableviewFrame;
    UIView          *containerView = nil;
    UIImageView     *backgroundView = nil;
    
    do{
        bounds = [[UIScreen mainScreen] bounds];
        
        containerView = [[[UIView alloc] initWithFrame:bounds] autorelease];
        break_if(containerView == nil);
        
        containerView.autoresizesSubviews = YES;
        containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search-bg.png"]] autorelease];
        backgroundView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
        
        [containerView addSubview:backgroundView];
        
        break_if(![self prepareNavigationBar]);

        // ---------------tableView-------------
        tableviewFrame = bounds;
            
        mTableView = [[UITableView alloc] initWithFrame:tableviewFrame style:UITableViewStyleGrouped];       
        mTableView.autoresizesSubviews = YES;
        mTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		mTableView.backgroundColor = [UIColor clearColor];
		mTableView.separatorColor = [UIColor grayColor];
		
        [containerView addSubview:mTableView];
        mTableView.delegate = self;
		mTableView.dataSource = self;
        // ---------------tableView-------------
        
        mCategorys = [[NSMutableArray alloc] initWithObjects:@"性价比最高", @"评分最高", @"色泽分区", @"葡萄产区", @"产地分区", @"按心情", @"按天气", @"食物搭配", @"按活动分类", @"附近推荐",nil];
        self.view = containerView;
        
    }while (0);
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
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return [mCategorys count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{			
    static NSString		*WineCellIdentifier = @"WineCell";
    UITableViewCell		*cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:WineCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WineCellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text = [mCategorys objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:190.0 green:190.0 blue:190.0 alpha:1.0];
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RedWineCategoryRowHeight;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id          controller = nil;
    NSArray     *datesArray = nil;
    
    switch (indexPath.row) {
        case 2:
            datesArray = [self prepareRedWineColorData];
            controller = [[RedWineCategoryViewController alloc] init];
            [controller setContents:datesArray];
            
            break;
            
        case 3:
        case 4:
            
            datesArray = [self prepareRedWinePlaceData];
            controller = [[RedWineCategoryViewController alloc] init];
            [controller setContents:datesArray];
            break;
            
        default:
            
            controller = [[RedWineListViewController alloc] init];
            break;
    }
    
    if (controller != nil) {
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
        controller = nil;
    }
}

#pragma mark -
#pragma mark Private

- (NSArray *)prepareRedWineColorData
{
    NSMutableDictionary    *dictionary = nil;
    NSMutableArray         *arrarys = nil;
    
    dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"色泽" forKey:kRedWineCategoryNameKey];
    [dictionary setValue:[NSArray arrayWithObjects:@"红葡萄酒", @"白葡萄酒", @"桃红酒", @"香槟", @"甜酒", nil] forKey:kRedWineCatagoryContentKey];
    
    arrarys = [[NSMutableArray alloc] init];
    [arrarys addObject:dictionary];
    [arrarys addObject:dictionary];
    [arrarys addObject:dictionary];
    
    [dictionary release];
    dictionary = nil;

    return arrarys;
}

- (NSArray *)prepareRedWinePlaceData
{
    NSMutableDictionary    *dictionary = nil;
    NSMutableArray         *arrarys = nil;
    
    arrarys = [[NSMutableArray alloc] init];
    
    dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"国家" forKey:kRedWineCategoryNameKey];
    [dictionary setValue:[NSArray arrayWithObjects:@"法国", @"美国", @"澳大利亚", @"西班牙", @"中国", nil] forKey:kRedWineCatagoryContentKey];
    
    [arrarys addObject:dictionary];
    [dictionary release];
    dictionary = nil;
    
    dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:@"产区" forKey:kRedWineCategoryNameKey];
    [dictionary setValue:[NSArray arrayWithObjects:@"纳帕谷", @"香槟区", @"波尔多", @"勃艮第", nil] forKey:kRedWineCatagoryContentKey];
    
    [arrarys addObject:dictionary];
    [dictionary release];
    dictionary = nil;
    
    return arrarys;
}

- (BOOL)prepareNavigationBar
{
    UIBarButtonItem     *leftItem = nil;
    UIButton            *leftButton = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:nil action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = NSLocalizedString(@"Red Wine Area Title", nil);
    
    [leftItem release];
    leftItem = nil;
    
#ifdef __IPHONE_5_0 
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
#endif 
    return YES;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
