//
//  RegisterViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//
#define HEIGHT_INTERVAL  15 
#import "RegisterViewController.h"
#import "PaoPaoConstant.h"
#import "QuartzCore/QuartzCore.h"

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
    [picButton release];
    picButton = nil;
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
    self.navigationItem.title = @"注册";
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
    mail.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    mail.placeholder = @"你的邮箱地址";
    [scrollView addSubview:mail];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, mail.frame.origin.y+mail.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.secureTextEntry = YES;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.font = [UIFont fontWithName:PaoPaoFont size:16];
    password.delegate = self;
    password.placeholder = @"密码（6-8个字符）";
    [scrollView addSubview:password];
    
    nibname = [[UITextField alloc] initWithFrame:CGRectMake(10, password.frame.origin.y+password.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    nibname.borderStyle = UITextBorderStyleRoundedRect;
    nibname.delegate = self;
    nibname.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    nibname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nibname.font = [UIFont fontWithName:PaoPaoFont size:16];
    nibname.placeholder = @"你的昵称";
    [scrollView addSubview:nibname];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(10, nibname.frame.origin.y+nibname.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.delegate = self;
    phone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phone.font = [UIFont fontWithName:PaoPaoFont size:16];
    phone.placeholder = @"你的手机号码";
    [scrollView addSubview:phone];

    //[self addToolbarAboveKeyboard];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, phone.frame.origin.y+phone.frame.size.height + HEIGHT_INTERVAL, 65, 65)];
    [imageView setImage:[UIImage imageNamed:@"female-icon.png"]];
    [imageView.layer setCornerRadius:3.0];
    [scrollView addSubview:imageView];
    
    UIButton *sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [sendButton setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height + HEIGHT_INTERVAL, 80, 25)];
    [sendButton addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    [sendButton setTitle:@"马上注册" forState:UIControlStateNormal];
    [scrollView addSubview:sendButton];
    [sendButton release];
    sendButton = nil;

}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    return CGRectOffset(bounds, 0, 10);
//}
//-(void)addToolbarAboveKeyboard
//{
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
//    toolBar.barStyle = UIBarStyleBlackTranslucent;
//    
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
//    
//    [toolBar setItems:[NSArray arrayWithObjects:space,done, nil]];
//    
//    mail.inputAccessoryView = toolBar;
//    password.inputAccessoryView = toolBar;
//    nibname.inputAccessoryView = toolBar;
//    phone.inputAccessoryView =toolBar;
//    
//    [toolBar release];
//    toolBar = nil;
//    [space release];
//    space = nil;
//    [done release];
//    done = nil;
//}
//-(void)dismissKeyBoard
//{
//    if ([mail isEditing]) {
//        [mail resignFirstResponder];
//    }else if ([password isEditing]) {
//        [password resignFirstResponder];
//    }else if ([nibname isEditing]) {
//        [nibname resignFirstResponder];
//    }else if ([phone isEditing]) {
//        [phone resignFirstResponder];
//    }
//}
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
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[picButton setImage:image forState:UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegat

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  NO;
}

@end
