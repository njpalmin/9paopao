//
//  SettingViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import "SettingViewController.h"
#import "PaoPaoConstant.h"
#import "QuartzCore/QuartzCore.h"

@implementation SettingViewController
@synthesize sectionNames,placeHolds;
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
    
    [sectionNames release];
    sectionNames = nil;
    
    [placeHolds release];
    placeHolds = nil;
    
    [email release];
    email = nil;
    
    [password release];
    password = nil;
    
    [user release];
    user = nil;
    
    [number release];
    number = nil;
    
    [imageButton release];
    imageButton = nil;
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
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-50)];
    scrollView.contentSize = scrollView.frame.size;
    [scrollView setBounces:YES];
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    self.placeHolds = [NSMutableArray arrayWithObjects:@"请输入你的邮箱地址",
                   @"**********",
                   @"你的用户名",
                   @"你的手机号码",
                   @"修改我的头像",nil];
    self.sectionNames = [NSMutableArray arrayWithObjects:@"邮箱地址",
                    @"密码",
                    @"昵称",
                    @"手机号码",
                    @"用户照片",nil];
    for (int i = 0; i<5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + i*60 , 320, 15)];
        label.text = [sectionNames objectAtIndex:i];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:PaoPaoFont size:14];
        [scrollView addSubview:label];
        [label release];
        label = nil;
    }
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(15, 32, 300, 30)];
    email.placeholder = [placeHolds objectAtIndex:0];
    email.delegate = self;
    email.font = [UIFont fontWithName:PaoPaoFont size:14];
    email.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:email];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(15, 32 +60, 300, 30)];
    password.placeholder = [placeHolds objectAtIndex:1];
    password.delegate = self;
    password.font = [UIFont fontWithName:PaoPaoFont size:14];
    password.secureTextEntry = YES;
    password.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:password];
    
    user = [[UITextField alloc] initWithFrame:CGRectMake(15, 32+60*2, 300, 30)];
    user.placeholder = [placeHolds objectAtIndex:2];
    user.delegate = self;
    user.font = [UIFont fontWithName:PaoPaoFont size:14];
    user.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:user];
    
    number = [[UITextField alloc] initWithFrame:CGRectMake(15, 32+60*3, 300, 30)];
    number.placeholder = [placeHolds objectAtIndex:3];
    number.delegate = self;
    number.tag = 101;
    number.font = [UIFont fontWithName:PaoPaoFont size:14];
    number.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:number];
    
    imageButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    [imageButton setFrame:CGRectMake(15, 32+60*4, 64, 64)];
    imageButton.layer.cornerRadius = 3.0;
    [imageButton setTitle:@"你的头像" forState:UIControlStateNormal];
    [imageButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:imageButton];
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

-(void)uploadImage:(id)sender
{
    UIImagePickerController	*imagePicker = nil;
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	
	[imagePicker release];
	imagePicker = nil;
}
#pragma mark -
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        scrollView.contentOffset = CGPointMake(0, 55);
        [UIView commitAnimations];
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 101) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        scrollView.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    [textField resignFirstResponder];
    return NO;
}
#pragma mark -
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[imageButton setImage:image forState:UIControlStateNormal];
    imageButton.layer.cornerRadius = 3.0;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
