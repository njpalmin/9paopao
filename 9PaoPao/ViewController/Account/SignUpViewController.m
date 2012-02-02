//
//  SignUpViewController.m
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//
#define HEIGHT_INTERVAL 15

#import "SignUpViewController.h"
#import "PaoPaoCommon.h"
#import "SearchManager.h"
#import "RegisterViewController.h"
#import "StringHelper.h"

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
    scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:scrollView];
    
    self.navigationItem.title = NSLocalizedString(@"Login",nil);
    UIButton            *leftButton = nil;
    UIBarButtonItem     *leftItem = nil;
    
    leftButton = [PaoPaoCommon getBarButtonWithTitle:nil imageName:@"return-button.png" highlightedImageName:nil action:@selector(procReturn:) target:self];
    
    leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftItem release];
    leftItem = nil;

    emailTop = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    emailTop.borderStyle = UITextBorderStyleRoundedRect;
    emailTop.delegate = self;
    emailTop.keyboardType = UIKeyboardTypeEmailAddress;
    emailTop.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailTop.backgroundColor = [UIColor clearColor];
    emailTop.font = [UIFont fontWithName:PaoPaoFont size:14];
    emailTop.placeholder = NSLocalizedString(@"Your nibname",nil);
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(10, emailTop.frame.origin.y+emailTop.frame.size.height + HEIGHT_INTERVAL, 300, 30)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.delegate = self;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.font = [UIFont fontWithName:PaoPaoFont size:14];
    password.secureTextEntry = YES;
    password.placeholder =NSLocalizedString(@"Password",nil);

    UIButton *btnRegister = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnRegister.frame = CGRectMake(55, password.frame.origin.y+password.frame.size.height + HEIGHT_INTERVAL, 90, 30);
    [btnRegister setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [btnRegister setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    btnRegister.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:14];
    btnRegister.backgroundColor = [UIColor clearColor];
    [btnRegister setTitle:NSLocalizedString(@"Register now",nil) forState:UIControlStateNormal];
    
    [btnRegister addTarget:self action:@selector(registNow:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnlogUp = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnlogUp.frame = CGRectMake(175, btnRegister.frame.origin.y, 90, 30);
    [btnlogUp setTitle:NSLocalizedString(@"Login now",nil) forState:UIControlStateNormal];
    btnlogUp.backgroundColor = [UIColor clearColor];
    [btnlogUp setBackgroundImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [btnlogUp setBackgroundImage:[UIImage imageNamed:@"upload-selected.png"] forState:UIControlStateHighlighted];
    btnlogUp.titleLabel.font = [UIFont fontWithName:PaoPaoFont size:14];
    [btnlogUp addTarget:self action:@selector(logUpNow:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *forgetlabel = [[UILabel alloc] initWithFrame:CGRectMake(password.frame.origin.x, btnRegister.frame.origin.y + btnRegister.frame.size.height + password.frame.size.height, 100, 20)];
    forgetlabel.text = NSLocalizedString(@"Forget password",nil);
    forgetlabel.textColor = [UIColor redColor];
    forgetlabel.font = [UIFont fontWithName:PaoPaoFont size:14];
    forgetlabel.backgroundColor = [UIColor clearColor];
    
    emailBottom = [[UITextField alloc] initWithFrame:CGRectMake(10, forgetlabel.frame.origin.y+forgetlabel.frame.size.height + HEIGHT_INTERVAL -5, 300, 30)];
    emailBottom.borderStyle = UITextBorderStyleRoundedRect;
    emailBottom.delegate =self;
    emailBottom.font = [UIFont fontWithName:PaoPaoFont size:14];
    emailBottom.tag = 101;
    emailBottom.keyboardType = UIKeyboardTypeEmailAddress;
    emailBottom.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailBottom.backgroundColor = [UIColor clearColor];
    emailBottom.placeholder = NSLocalizedString(@"Your email address",nil);
    
    UIButton *btnSend = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btnSend.frame = CGRectMake(115, emailBottom.frame.origin.y+emailBottom.frame.size.height + HEIGHT_INTERVAL-5, 90, 30);
    [btnSend setImage:[UIImage imageNamed:@"send-button.png"] forState:UIControlStateNormal];
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
    RegisterViewController *regViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regViewController animated:YES];
    [regViewController release];
}

-(void)logUpNow:(id)sender
{
    NSLog(@"%@ : %@",emailTop.text,password.text);
    NSString *str = [StringHelper stringByTrimEnds:emailTop.text];
    if (!str || [str isEqualToString:@""]) {
        UIAlertView *alert = nil;
        NSString *title = NSLocalizedString(@"Alert", nil);
        NSString *message = NSLocalizedString(@"Email address is null",nil);  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;
        return;
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

    [SearchManager defaultSearchManager].delegate =self;
    [[SearchManager defaultSearchManager] startLoginWithUserName:emailTop.text 
                                                     andPassword:password.text 
                                                    andSessionId:nil];
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
// MARK:- 
// MARK:- SearchManagerDelegate
- (void)finishLoginWithReturnInfo:(NSDictionary *)dic
{
    NSLog(@"Login return info: %@",dic);
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
        NSString *message = NSLocalizedString(@"Login successed", nil);  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;
        
    }

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

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
