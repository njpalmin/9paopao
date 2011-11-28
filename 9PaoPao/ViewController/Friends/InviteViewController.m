//
//  InviteViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import "InviteViewController.h"

@implementation InviteViewController

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
    [toEmail release];
    toEmail = nil;
    [subject release];
    subject = nil;
    [content release];
    content = nil;

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
    self.navigationItem.title = @"邀请好友";
    
    UIBarButtonItem *rightBtn= [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
    rightBtn = nil;
    
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
    toLabel.text = @"To:";
    toLabel.backgroundColor = [UIColor clearColor];
    toLabel.textColor = [UIColor lightGrayColor];
    
    toEmail = [[UITextField alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x+toLabel.frame.size.width, toLabel.frame.origin.y, 320 -(toLabel.frame.origin.x+toLabel.frame.size.width)-50, toLabel.frame.size.height)];
    toEmail.delegate = self;
    toEmail.text =@"";
    
    UIButton *addButton = [[UIButton buttonWithType:UIButtonTypeContactAdd] retain];
    addButton.frame = CGRectMake(320-30, toLabel.frame.origin.y, 20, 20);
    [addButton addTarget:self action:@selector(addFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self drawLineWithMinX:0.0 MinY:(toLabel.frame.origin.y +toLabel.frame.size.height +10) MaxX:320 MaxY:(toLabel.frame.origin.y +toLabel.frame.size.height +10)];
    
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, toLabel.frame.origin.y +toLabel.frame.size.height +20, 320, 20)];
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.text = @"Cc/Bcc,From: samsfnsakfk@slsamdlskfsdmfk.com";
    fromLabel.textColor = [UIColor lightGrayColor];
    
    //[self drawLineWithMinX:0.0 MinY:(fromLabel.frame.origin.y +fromLabel.frame.size.height +10) MaxX:320 MaxY:(fromLabel.frame.origin.y +fromLabel.frame.size.height)];
    
    UILabel *subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, fromLabel.frame.origin.y +fromLabel.frame.size.height +20, 80, 20)];
    subjectLabel.textColor = [UIColor lightGrayColor];
    subjectLabel.text = @"Subject:";
    subjectLabel.backgroundColor = [UIColor clearColor];
    
    subject = [[UITextField alloc] initWithFrame:CGRectMake(subjectLabel.frame.origin.x+subjectLabel.frame.size.width, subjectLabel.frame.origin.y, 320 -(subjectLabel.frame.origin.x+subjectLabel.frame.size.width)-50, subjectLabel.frame.size.height+10)];
    subject.delegate = self;
    subject.text = @"好酒";
    
    //[self drawLineWithMinX:0.0 MinY:(subjectLabel.frame.origin.y +subjectLabel.frame.size.height +10) MaxX:320 MaxY:(subjectLabel.frame.origin.y +subjectLabel.frame.size.height +10)];
    
    content = [[UITextView alloc] initWithFrame:CGRectMake(0, subjectLabel.frame.origin.y +subjectLabel.frame.size.height +20, 320, 460 -(subjectLabel.frame.origin.y +subjectLabel.frame.size.height +20))];
    content.contentInset = UIEdgeInsetsZero;
    content.text = @"sdjfasjfasjfljsfljfljsafsajfslajflasjflasjflsaffsfsdfsdfsdfsdjslkafjslakfjlasjflsaj";
    [self.view addSubview:toLabel];
    [self.view addSubview:toEmail];
    [self.view addSubview:addButton];
    [self.view addSubview:fromLabel];
    [self.view addSubview:subjectLabel];
    [self.view addSubview:subject];
    [self.view addSubview:content];
    
    [toLabel release];
    toLabel = nil;
    [addButton release];
    addButton = nil;
    [fromLabel release];
    fromLabel = nil;
    [subjectLabel release];
    subjectLabel = nil;
    
    phoneNumbers = [[NSMutableArray alloc] initWithCapacity:0];
}
-(void)send
{
    
}
-(void)addFriends:(id)sender
{
    ABPeoplePickerNavigationController *people = [[ABPeoplePickerNavigationController alloc] init];
    people.peoplePickerDelegate = self;
    people.addressBook = ABAddressBookCreate();
    people.displayedProperties = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty ], nil];
    [self.navigationController presentModalViewController:people animated:YES];
    [people release];
    people = nil;
}

/*******************************************************************************
 函数名称    : drawListLineWithMinX
 函数描述    : 根据（minX,minY）(maxX,maxY)画直线
 输入参数    : 直线的端点坐标
 输出参数    : N/A
 返回值      : N/A
 备注       : N/A
 *******************************************************************************/
//- (void)drawLineWithMinX:(CGFloat)minX MinY:(CGFloat)minY MaxX:(CGFloat)maxX MaxY:(CGFloat)maxY
//{
//	CGContextRef ctx = UIGraphicsGetCurrentContext();
//	
//    CGContextSetRGBStrokeColor(ctx, 0.667, 0.667, 0.667, 1.0);
//    CGContextSetLineWidth(ctx, 1.0);
//	CGContextMoveToPoint	(ctx, minX, minY);
//	CGContextAddLineToPoint	(ctx, maxX, maxY);
//	CGContextStrokePath		(ctx);
//}

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
#pragma mark UIImagePickerControllerDelegat

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  NO;
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate

// Called after the user has pressed cancel
// The delegate is responsible for dismissing the peoplePicker
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePicker:\n%@",peoplePicker);
    [peoplePicker dismissModalViewControllerAnimated:YES];
}

// Called after a person has been selected by the user.
// Return YES if you want the person to be displayed.
// Return NO  to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *num = (NSString *)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
    //[phoneNumbers addObject:num];
    toEmail.text = [toEmail.text stringByAppendingFormat:@"%@;",num];
    [num release];
    [peoplePicker dismissModalViewControllerAnimated:YES];
    return YES;
}

// Called after a value has been selected by the user.
// Return YES if you want default action to be performed.
// Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}

@end
