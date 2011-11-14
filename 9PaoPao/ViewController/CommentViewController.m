//
//  CommentViewController.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import "CommentViewController.h"
#import "PaoPaoCommon.h"
#import "ScoreView.h"
#import "ToolBarView.h"

@implementation CommentViewController

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
    [commentsText release];
    [scrollView release];
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
    self.navigationItem.title = @"高级搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
    scrollView.contentSize = scrollView.frame.size;
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    [scrollView setBounces:YES];
    scrollView.userInteractionEnabled = YES;
    [self.view addSubview:scrollView];
    
    UIButton *leftButton = [PaoPaoCommon getImageButtonWithName:@"返回" highlightName:@"返回" action:@selector(goBack:) target:self];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftButton] autorelease];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 14, 50, 18)];
    scoreLabel.text = @"评分";
    [scrollView addSubview:scoreLabel];
    [scoreLabel release];
    
    ScoreView *scoreView = [[ScoreView alloc] initWithFrame:CGRectMake(60, 28, 196, 187)];
    [scrollView addSubview:scoreView];
    [scoreView release];
    
    UILabel *commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 221, 140, 18)];
    commentsLabel.text = @"用户评论";
    [scrollView addSubview:commentsLabel];
    [commentsLabel release];
    
    commentsText = [[UITextView alloc] initWithFrame:CGRectMake(40, 243, 240, 90)];
    commentsText.text = @"fhsajfsamflsamflsafmlsafslfmsfmlsmflasmfslmflsmflsamflsmflsf";
    commentsText.scrollEnabled = YES;
    commentsText.delegate = self;
    commentsText.keyboardType = UIReturnKeyDone;
    commentsText.contentInset = UIEdgeInsetsZero;
    [self addTooBarOnKeyboard];
    [scrollView addSubview:commentsText];
    
    ToolBarView *toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, 333, 320, 30)];
    toolBarView.delegate = self;
    [scrollView addSubview:toolBarView];
    [toolBarView release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 }

-(void)addTooBarOnKeyboard
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];  
    [topView setBarStyle:UIBarStyleBlack];  
    
    //UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStyleBordered target:self action:nil];  
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];  
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];  
    [doneButton release];  
    [btnSpace release];  
    
    [topView setItems:buttonsArray];  
    [commentsText setInputAccessoryView:topView];  
}

-(void)dismissKeyBoard  
{  
    [commentsText resignFirstResponder];  
} 

-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 136) animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [commentsText resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -  ToolBarViewDelegate
-(void)locateMySelf
{

}
-(void)takePhoto
{

}
-(void)inputPoundSign
{

}

-(void)follow
{

}
-(void)showEmotion
{

}
@end
