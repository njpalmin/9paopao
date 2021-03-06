//
//  RegisterViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//
#define HEIGHT_INTERVAL  15 
#import "RegisterViewController.h"
#import "PaoPaoCommon.h"
#import "QuartzCore/QuartzCore.h"
#import "StringHelper.h"

@implementation RegisterViewController

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
    [scrollView release];
    scrollView = nil;
    [mail release];
    mail = nil;
    [password release];
    password = nil;
    [nibname release];
    nibname = nil;
    [phone release];
    phone = nil;
    [imageView release];
    imageView = nil;
    [registerButton release];
    registerButton =nil;
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
    self.navigationItem.title =NSLocalizedString(@"Register", nil);
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-50)];
    scrollView.contentSize = scrollView.frame.size;
    [scrollView setBounces:YES];
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];

    [self.view addSubview:scrollView];
    
    mail = [[UITextField alloc] initWithFrame:CGRectMake(10, HEIGHT_INTERVAL, 300, 30)];
    mail.borderStyle = UITextBorderStyleRoundedRect;
    mail.delegate = self;
    mail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mail.font = [UIFont fontWithName:PaoPaoFont size:16];
    mail.backgroundColor = [UIColor clearColor];
    mail.placeholder = NSLocalizedString(@"Your email address",nil);
    mail.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollView addSubview:mail];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, mail.frame.origin.y+mail.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.font = [UIFont fontWithName:PaoPaoFont size:16];
    password.delegate = self;
    password.placeholder = NSLocalizedString(@"Password (6-8 charactors)",nil);
    [scrollView addSubview:password];
    
    nibname = [[UITextField alloc] initWithFrame:CGRectMake(10, password.frame.origin.y+password.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    nibname.borderStyle = UITextBorderStyleRoundedRect;
    nibname.delegate = self;
    nibname.backgroundColor = [UIColor clearColor];
    nibname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nibname.font = [UIFont fontWithName:PaoPaoFont size:16];
    nibname.placeholder = NSLocalizedString(@"Your nibname",nil);
    [scrollView addSubview:nibname];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(10, nibname.frame.origin.y+nibname.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.delegate = self;
    phone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phone.font = [UIFont fontWithName:PaoPaoFont size:16];
    phone.placeholder = NSLocalizedString(@"Your cell phone number",nil);
    [scrollView addSubview:phone];

    //[self addToolbarAboveKeyboard];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, phone.frame.origin.y+phone.frame.size.height + HEIGHT_INTERVAL, 65, 65)];
    [imageView setImage:[UIImage imageNamed:@"female-icon.png"]];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setCornerRadius:10.0];
    
    [scrollView addSubview:imageView];
    
    UIButton *changePicBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [changePicBtn setFrame:CGRectMake(5+64+20, 60*4-15, 110, 30)];
    [changePicBtn addTarget:self action:@selector(upLoadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [changePicBtn setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [changePicBtn setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    [changePicBtn setTitle:NSLocalizedString(@"Change my picture",nil) forState:UIControlStateNormal];
    changePicBtn.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:13];
    [scrollView addSubview:changePicBtn];
    [changePicBtn release];
    changePicBtn = nil;

    
    UIButton *sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [sendButton setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height + HEIGHT_INTERVAL, 90, 30)];
    [sendButton addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    [sendButton setTitle:NSLocalizedString(@"Register now",nil) forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:14];
    [scrollView addSubview:sendButton];
    [sendButton release];
    sendButton = nil;

    UIButton            *leftButton = nil;
    UIBarButtonItem     *leftItem = nil;

    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:nil action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftItem release];
    leftItem = nil;
    
    [self addToolbarAboveKeyboard];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectOffset(bounds, 0, 10);
}
-(void)addToolbarAboveKeyboard
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,done, nil]];
    
    mail.inputAccessoryView = toolBar;
    password.inputAccessoryView = toolBar;
    nibname.inputAccessoryView = toolBar;
    phone.inputAccessoryView =toolBar;
    
    [toolBar release];
    toolBar = nil;
    [space release];
    space = nil;
    [done release];
    done = nil;
}
-(void)dismissKeyBoard
{
    if ([mail isEditing]) {
        [mail resignFirstResponder];
    }else if ([password isEditing]) {
        [password resignFirstResponder];
    }else if ([nibname isEditing]) {
        [nibname resignFirstResponder];
    }else if ([phone isEditing]) {
        [phone resignFirstResponder];
    }
}

-(void)upLoadPicture:(id)sender
{
    UIImagePickerController	*imagePicker = nil;
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	
	[imagePicker release];
	imagePicker = nil;
}

-(void)registerAccount:(id)sender
{
    //check the content whether null
    NSArray *texts = [NSArray arrayWithObjects:nibname.text,mail.text,phone.text, nil];
    NSArray *popTips = [NSArray arrayWithObjects:NSLocalizedString(@"Nibname is null",nil),
                        NSLocalizedString(@"Email address is null",nil),
                        NSLocalizedString(@"Cell phone number is null",nil), nil];
    
    for (int i = 0;i<[texts count];i++) {
        NSString *str = [StringHelper stringByTrimEnds:[texts objectAtIndex:i]];
        if (!str || [str isEqualToString:@""]) {
            UIAlertView *alert = nil;
            NSString *title = NSLocalizedString(@"Alert", nil);
            NSString *message = [popTips objectAtIndex:i];  
            
            alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
            [alert release];
            alert = nil;
            return;
        }
    }
    if (!password.text || [password.text isEqualToString:@""]) {
        UIAlertView *alert = nil;
        NSString *title = NSLocalizedString(@"Alert", nil);
        NSString *message = NSLocalizedString(@"Password must not be null",nil);  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;
        return;
    }
    
    [SearchManager defaultSearchManager].delegate = self;
    [[SearchManager defaultSearchManager] startRegisterWithUserName:nibname.text 
                                                           andEmail:mail.text 
                                                     andPhoneNumber:phone.text 
                                                        andPassword:password.text 
                                                       andSessionId:nil];
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

// MARK: -
// MARK: - SearchManagerDelegate
- (void)finishRegisterWithReturnInfo:(NSDictionary *)dic
{
    NSLog(@"register return info: %@",dic);

    if ([dic objectForKey:@"error"]) {
        UIAlertView *alert = nil;
        NSString *title = NSLocalizedString(@"Alert", nil);
        NSString *message = [dic objectForKey:@"error"];  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;
    }else{
        UIAlertView *alert = nil;
        NSString *title = nil;
        NSString *message = NSLocalizedString(@"Register successed", nil);  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;

    }
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	imageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == phone) {
        [scrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == phone) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  NO;
}

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
