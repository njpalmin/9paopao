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
#import "PaoPaoCommon.h"
#import "LocationTableViewController.h"
#import "LocationDetail.h"


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
        totalSection = 2;
        hasLocated = NO;
        hasFollowed = NO;
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
    drinkWineTableView = [[UITableView alloc] initWithFrame:view.frame style:UITableViewStyleGrouped];
    drinkWineTableView.delegate = self;
    drinkWineTableView.dataSource = self;
    
    [view addSubview:drinkWineTableView];
    self.view = view;
    toolBar = [[ToolBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    toolBar.delegate = self;
    foodLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    foodLable.backgroundColor = [UIColor clearColor];
    locationLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    locationLable.backgroundColor = [UIColor clearColor];
    
    mapVC = [[MapViewController alloc] init]; 
    
    sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"用户相册", nil];
    sheetView.frame = CGRectMake(0, 213, 320, 300);
    
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.text = @"评论";
    
    commentView = [[UITextView alloc] initWithFrame:CGRectMake(50, 0, 260, 50)];
    commentView.delegate = self;
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
    if (foodLable) {
        [foodLable release];
        foodLable = nil;
    }
    if (locationLable) {
        [locationLable release];
        locationLable = nil;
    }
    if (mapVC) {
        [mapVC release];
        mapVC = nil;
    }
    if (sheetView) {
        [sheetView release];
        sheetView = nil;
    }
    if (commentLabel) {
        [commentLabel release];
        commentLabel = nil;
    }
    if (commentView) {
        [commentView release];
        commentView = nil;
    }
    [super dealloc];
}

#pragma mark ---------
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
    if (hasLocated) {
        if ([indexPath section] == 1) {
            LocationDetail *object = [[LocationDetail alloc] init];
            object.location = @"中西院";
            object.detailLocation = @"当前位置";
            NSArray *array = [NSArray arrayWithObjects:object,object,object,object, nil];
            LocationTableViewController *locationVC = [[LocationTableViewController alloc] initWithShowContentArray:array];
            [self.navigationController pushViewController:locationVC animated:YES];
            [locationVC release];
            [object release];
            object = nil;
        }
    }
}

#pragma mark -------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return totalSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    if ([indexPath section ] == 0) {
        
        foodLable.text = withFood;
        if ([foodLable superview] != nil) {
            [foodLable removeFromSuperview];
        }
        [cell.contentView addSubview:foodLable];
        
    }else if([indexPath section] == 1 )
    {
        if ([toolBar superview] != nil) {
            [toolBar removeFromSuperview];
        }

        if (hasLocated ) {
            if ([locationLable superview] != nil) {
                [locationLable removeFromSuperview];
            }
            locationLable.text = @"中西远";
            [cell.contentView addSubview:locationLable];
            

        }else
        {
           [cell.contentView addSubview:toolBar];
        }
    }else if([indexPath section] == 2)
    {
        if (hasFollowed) {
            if ([commentLabel superview] != nil) {
                [commentLabel removeFromSuperview];
            }
            if ([commentView superview] != nil) {
                [commentView removeFromSuperview];
            }
            [cell.contentView addSubview:commentLabel];
            [cell.contentView addSubview:commentView];
        }else
        {
            if ([mapVC.view superview] != nil) {
                [mapVC.view removeFromSuperview];
            }
            mapVC.view.frame = CGRectMake(0, 0, 320, 30);
            [cell.contentView addSubview:mapVC.view];
        }
    }else if([indexPath section] == 3)
    {
        if ([toolBar superview] != nil) {
            [toolBar removeFromSuperview];
        }
        [cell.contentView addSubview:toolBar];
    }
    return cell;
}

#pragma mark ------
#pragma mark ToolBarViewDelegate
- (void)locateMySelf
{
    if (hasFollowed) {
        hasFollowed = NO;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];
        [insertSet addIndexes:indexSet];
        totalSection -= 1;
        [drinkWineTableView beginUpdates];
        [drinkWineTableView deleteSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
        [drinkWineTableView endUpdates];
        [insertSet release];
    }

    if (![[CoreLocationService shareLocationService] locationServiceEnabled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"本机的定位服务不可用" message:@"您无法启用设备上的定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }else
    {
        if (!hasLocated) {
            hasLocated = YES;
            NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndex:2];
            NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndex:3];
            NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];
            [insertSet addIndexes:indexSet1];
            [insertSet addIndexes:indexSet2];
            totalSection += 2;
            [drinkWineTableView beginUpdates];
            [drinkWineTableView insertSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
            [drinkWineTableView endUpdates];
            [insertSet release];
           // [drinkWineTableView reloadData];
            
        }
       
        
    }
}

- (void)takePhoto
{
    sheetView.actionSheetStyle = UIActionSheetStyleBlackTranslucent;    
    [sheetView showInView:self.view.superview];
    if (hasLocated) {
        hasLocated = NO;
        NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndex:1];
        NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndex:2];
        NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];

        [insertSet addIndexes:indexSet1];
        [insertSet addIndexes:indexSet2];
         totalSection -= 2;
        [drinkWineTableView beginUpdates];
        [drinkWineTableView deleteSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
        [drinkWineTableView endUpdates];
        [insertSet release];
       // [drinkWineTableView reloadData];
       
       
    }
    if (hasFollowed) {
        hasFollowed = NO;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];
        [insertSet addIndexes:indexSet];
        totalSection -= 1;
        [drinkWineTableView beginUpdates];
        [drinkWineTableView deleteSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
        [drinkWineTableView endUpdates];
        [insertSet release];
    }
   
}

- (void)inputPoundSign
{
    if (hasLocated) {
        hasLocated = NO;
        NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndex:1];
        NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndex:2];
        NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];
        
        [insertSet addIndexes:indexSet1];
        [insertSet addIndexes:indexSet2];
        totalSection -= 2;
        [drinkWineTableView beginUpdates];
        [drinkWineTableView deleteSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
        [drinkWineTableView endUpdates];
        [insertSet release];
        // [drinkWineTableView reloadData];
        
        
    }
    if (!hasFollowed) {
        hasFollowed = YES;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:2];
        NSMutableIndexSet *insertSet = [[NSMutableIndexSet alloc] init];
        [insertSet addIndexes:indexSet];
        totalSection += 1;
        [drinkWineTableView beginUpdates];
        [drinkWineTableView insertSections:insertSet withRowAnimation:UITableViewRowAnimationFade];
        [drinkWineTableView endUpdates];
        [insertSet release];
    }
   
}

#pragma mark -------------
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"ggggg");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imagePicker animated:YES];
            [imagePicker release];
            
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
            
        }
        
    }else if(buttonIndex == 1)
    {
        NSLog(@"ffffff");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:imagePicker animated:YES];
            [imagePicker release];
            
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"相册不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
            
        }

    }
    else if(buttonIndex == 2)
    {
        NSLog(@"dddddd");
    }
}

#pragma mark ------
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
