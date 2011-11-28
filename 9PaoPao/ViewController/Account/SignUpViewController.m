//
//  SignUpViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//
#define HEIGHT_INTERVAL 15

#import "SignUpViewController.h"


@implementation SignUpViewController

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
    [emailTop release];
    emailTop = nil;
    [emailBottom release];
    emailBottom = nil;
    [password release];
    password = nil;
    [scrollView release];
    scrollView = nil;
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
    scrollView.bounces = YES;
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled =YES;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    self.navigationItem.title = @"登陆";
    emailTop = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    emailTop.borderStyle = UITextBorderStyleRoundedRect;
    emailTop.delegate = self;
    emailTop.placeholder = @"邮箱地址";
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, emailTop.frame.origin.y+emailTop.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.delegate = self;
    password.secureTextEntry = YES;
    password.placeholder = @"密码";

    UIButton *btnRegister = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btnRegister.frame = CGRectMake(55, password.frame.origin.y+password.frame.size.height + HEIGHT_INTERVAL, 80, 25);
    [btnRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(registNow:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnlogUp = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btnlogUp.frame = CGRectMake(185, btnRegister.frame.origin.y, 80, 25);
    [btnlogUp setTitle:@"马上注册" forState:UIControlStateNormal];
    [btnlogUp addTarget:self action:@selector(logUpNow:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *forgetlabel = [[UILabel alloc] initWithFrame:CGRectMake(password.frame.origin.x, btnRegister.frame.origin.y + btnRegister.frame.size.height + password.frame.size.height, 100, 20)];
    forgetlabel.text = @"忘记密码？";
    forgetlabel.backgroundColor = [UIColor clearColor];
    
    emailBottom = [[UITextField alloc] initWithFrame:CGRectMake(10, forgetlabel.frame.origin.y+forgetlabel.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    emailBottom.borderStyle = UITextBorderStyleRoundedRect;
    emailBottom.delegate =self;
    emailBottom.tag = 101;
    emailBottom.placeholder = @"邮箱地址";
    
    UIButton *btnSend = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    btnSend.frame = CGRectMake(320-80-10, emailBottom.frame.origin.y+emailBottom.frame.size.height + HEIGHT_INTERVAL, 80, 25);
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];

    [scrollView addSubview:emailTop];
    [scrollView addSubview:password];
    [scrollView addSubview:btnRegister];
    [scrollView addSubview:btnlogUp];
    [scrollView addSubview:forgetlabel];
    [scrollView addSubview:emailBottom];
    [scrollView addSubview:btnSend];
    
    [btnRegister release];
    btnRegister = nil;
    [btnlogUp release];
    btnlogUp = nil;
    [forgetlabel release];
    forgetlabel = nil;
    [btnSend release];
    btnSend = nil;
}

-(void)registNow:(id)sender
{

}

-(void)logUpNow:(id)sender
{
    
}


-(void)send:(id)sender
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
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        scrollView.contentOffset = CGPointMake(0, 83);
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


@end
