//
//  InviteViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import "InviteViewController.h"
#import "LineView.h"
#import "PaoPaoConstant.h"
@implementation InviteViewController
@synthesize phoneNumbers;

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
    [phoneNumbers release];
    phoneNumbers = nil;
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
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-50)];
    scrollView.contentSize = scrollView.frame.size;
    [scrollView setBounces:YES];
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    
    UIButton *sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [sendButton setFrame:CGRectMake(70, 5, 80, 30)];
    [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    sendButton.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:13];
    sendButton.titleLabel.textAlignment = UITextAlignmentRight;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    UIButton *cancelButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [cancelButton setFrame:CGRectMake(sendButton.frame.origin.x +sendButton.frame.size.width+20, sendButton.frame.origin.y, 80, 30)];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:13];
    cancelButton.titleLabel.textAlignment = UITextAlignmentRight;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    CGFloat yPos = cancelButton.frame.origin.y + cancelButton.frame.size.height;
    
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, yPos+10, 30, 25)];
    toLabel.text = @"To:";
    toLabel.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    toLabel.backgroundColor = [UIColor clearColor];
    toLabel.textColor = [UIColor lightGrayColor];
    
    toEmail = [[UITextField alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x+toLabel.frame.size.width, toLabel.frame.origin.y, 320 -(toLabel.frame.origin.x+toLabel.frame.size.width)-50, toLabel.frame.size.height)];
    toEmail.delegate = self;
    toEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    toEmail.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    toEmail.text =@"";
    
    UIButton *addButton = [[UIButton buttonWithType:UIButtonTypeContactAdd] retain];
    addButton.frame = CGRectMake(320-30, toLabel.frame.origin.y, 25, 25);
    [addButton addTarget:self action:@selector(addFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    LineView *line1 = [[LineView alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, toLabel.frame.origin.y +toLabel.frame.size.height +1.5, 300, 1)];
        
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, line1.frame.origin.y +line1.frame.size.height +15, 300, 25)];
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.lineBreakMode = UILineBreakModeTailTruncation;
    fromLabel.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    fromLabel.lineBreakMode = UILineBreakModeTailTruncation;
    fromLabel.text = @"Cc/Bcc,From: samsfnsakfk@slsamdlskfsdmfk.com";
    fromLabel.textColor = [UIColor lightGrayColor];
    
    LineView *line2 = [[LineView alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, fromLabel.frame.origin.y +fromLabel.frame.size.height +1.5, 300, 1)];
    
    UILabel *subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, line2.frame.origin.y +line2.frame.size.height +15, 80, 25)];
    subjectLabel.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    subjectLabel.textColor = [UIColor lightGrayColor];
    subjectLabel.text = @"Subject:";
    subjectLabel.backgroundColor = [UIColor clearColor];
    
    subject = [[UITextField alloc] initWithFrame:CGRectMake(subjectLabel.frame.origin.x+subjectLabel.frame.size.width, subjectLabel.frame.origin.y-3, 320 -(subjectLabel.frame.origin.x+subjectLabel.frame.size.width)-50, subjectLabel.frame.size.height+10)];
    subject.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    subject.delegate = self;
    subject.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    subject.text = @"好酒";
    
    LineView *line3 = [[LineView alloc] initWithFrame:CGRectMake(toLabel.frame.origin.x, subjectLabel.frame.origin.y +subjectLabel.frame.size.height +1.5, 300, 1)];
    
    content = [[UITextView alloc] initWithFrame:CGRectMake(0, line3.frame.origin.y +line3.frame.size.height +5, 320, 460-44-216-60)];
    content.contentInset = UIEdgeInsetsZero;
    content.delegate =self;
    content.font = [UIFont fontWithName:PaoPaoFont size:14.0];
    content.text = @"sdjfasjfasjfljsfljfljsafsajfslajflasjflasjflsaffsfsdfsdfsdfsdjslkafjslakfjlasjflsaj";
    
    [scrollView addSubview:sendButton];
    [scrollView addSubview:cancelButton];
    [scrollView addSubview:toLabel];
    [scrollView addSubview:toEmail];
    [scrollView addSubview:addButton];
    [scrollView addSubview:fromLabel];
    [scrollView addSubview:subjectLabel];
    [scrollView addSubview:subject];
    [scrollView addSubview:content];
    [scrollView addSubview:line1];
    [scrollView addSubview:line2];
    [scrollView addSubview:line3];

    [sendButton release];
    sendButton = nil;
    [cancelButton release];
    cancelButton = nil;
    [line1 release];
    line1 = nil;
    [line2 release];
    line2 = nil;
    [line3 release];
    line3 = nil;
    [toLabel release];
    toLabel = nil;
    [addButton release];
    addButton = nil;
    [fromLabel release];
    fromLabel = nil;
    [subjectLabel release];
    subjectLabel = nil;
    
    phoneNumbers = [[NSMutableArray alloc] initWithCapacity:0];
    [self addToolbarAboveKeyboard];
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

#pragma mark - implement

-(void)send:(id)sender
{
    
}

-(void)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addFriends:(id)sender
{
    ABPeoplePickerNavigationController *people = [[ABPeoplePickerNavigationController alloc] init];
    people.peoplePickerDelegate = self;
    people.displayedProperties = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty ], nil];
    [self.navigationController presentModalViewController:people animated:YES];
    [people release];
    people = nil;
}

-(void)addToolbarAboveKeyboard
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,done, nil]];
    
    content.inputAccessoryView = toolBar;
        
    [toolBar release];
    toolBar = nil;
    [space release];
    space = nil;
    [done release];
    done = nil;
}


-(void)dismissKeyBoard
{
    [content resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView commitAnimations];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    scrollView.contentOffset = CGPointMake(0, content.frame.origin.y-50);
    [UIView commitAnimations];
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
    NSLog(@"person:\n %@",person);
    //get person name
    NSString *string = (NSString *)ABRecordCopyCompositeName(person);
    
    //get person phoneNumbers
    CFTypeRef theProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray *items = (NSArray *)ABMultiValueCopyArrayOfAllValues(theProperty);
    CFRelease(theProperty);
    NSLog(@"his phone number:\n %@",items);
    
    [self.phoneNumbers addObjectsFromArray:items];
    NSLog(@"all phone numbers:\n %@",phoneNumbers);
    [items release];
    items = nil;
    //show his name
    toEmail.text = [toEmail.text stringByAppendingFormat:@"%@;",string];
    [string release];
    [peoplePicker dismissModalViewControllerAnimated:YES];
    return NO;
}

// Called after a value has been selected by the user.
// Return YES if you want default action to be performed.
// Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}

@end
