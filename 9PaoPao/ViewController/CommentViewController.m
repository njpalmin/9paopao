//
//  CommentViewController.m
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//
#define EMOJI_HEIGHT 158

#import "CommentViewController.h"
#import "PaoPaoCommon.h"
#import "ScoreView.h"
#import "ToolBarView.h"
#import "EmojiView.h"

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
    [toolBarView release];
    [emojiView release];
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
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    leftItem = nil;
    
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
    
    toolBarView = [[ToolBarView alloc] initWithFrame:CGRectMake(0, 333, 320, 30)];
    toolBarView.delegate = self;
    [scrollView addSubview:toolBarView];
    
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
    [self showKeyBoard];
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    [self hideKeyBoard];
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

#pragma mark -
#pragma mark UIImagePickerControllerDelegat

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, PageWithoutSegementHeight)];
}

#pragma mark -
#pragma mark LocationManagerDelegate

- (void)locationManagerUpdateHeading:(LocationManager*)controller
{
	CLLocation	*location = nil;
	
	location = controller.newLocation;
}

- (void)locationManager:(LocationManager*)controller didReceiveError:(NSError*)error
{
	
}

#pragma mark -  EmojiViewDelegate
-(void)showEmojiInMessage:(NSString *)text
{
    commentsText.text = [commentsText.text stringByAppendingString:text];
}

#pragma mark -  ToolBarViewDelegate
-(void)locateMySelf
{
    [self hideEj];

	if (mLocationManager == nil) {
		mLocationManager = [[LocationManager alloc] init];
	}
	
	if (mLocationManager == nil) {

		NSString    *message = @"Location service not Support";
		NSString    *title = @"Alert";
		UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[noCompassAlert show];
		[noCompassAlert release];
		noCompassAlert = nil;
		
	}else{
		mLocationManager.delegate = self;
		[mLocationManager stopUpdate];
		[mLocationManager startUpdate];
	}	
}

-(void)takePhoto
{
    [self hideEj];

	UIImagePickerController	*imagePicker = nil;
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	
	[self presentModalViewController:imagePicker animated:YES];
	
	[imagePicker release];
	imagePicker = nil;	
}

-(void)inputPoundSign
{
    [self hideEj];
     commentsText.text = [commentsText.text stringByAppendingString:@"#"];
}

-(void)follow
{
    [self hideEj];
    commentsText.text = [commentsText.text stringByAppendingString:@"@"];
}

-(void)showKeyBoard
{
    NSLog(@"keyboard shows");
    //keybord show
    scrollView.scrollEnabled = YES;
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 216-20) animated:YES];
    
    //emojiview hide if poped
    if (isEmojiPoped) {
        NSLog(@"emoji hide in keyboard show ");
        scrollView.scrollEnabled = NO;
        
        [UIView beginAnimations:@"hideEmojiView" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
        [UIView commitAnimations];
        
        isEmojiPoped = NO;
    }
    
    scrollView.scrollEnabled = NO;
}
-(void)hideKeyBoard
{
    NSLog(@"keyboard hides");
    //keybord hide
    scrollView.scrollEnabled = YES;
    if (!isEmojiPoped){
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(void)hideEj
{
    scrollView.scrollEnabled = YES;
    isEmojiPoped = NO;
    
    NSLog(@"emoji hides");
    [UIView beginAnimations:@"hideEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [emojiView setFrame:CGRectMake(0, 480-20-44, 320, EMOJI_HEIGHT)];
    [UIView commitAnimations];
}

-(void)showEj
{
   
    isEmojiPoped = YES;
    //hide keyborad if keyboard showing
    [commentsText resignFirstResponder];
    
    scrollView.scrollEnabled = YES;
    
     NSLog(@"emoji shows");
    [UIView beginAnimations:@"popEmojiView" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES]; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [emojiView setFrame:CGRectMake(0, 480-EMOJI_HEIGHT-44-20, 320, EMOJI_HEIGHT)];
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, EMOJI_HEIGHT - 50) animated:YES];
    [UIView commitAnimations];
    
    scrollView.scrollEnabled = NO;
}


-(void)showEmotion
{
    if (!emojiView) {
        emojiView = [[EmojiView alloc] initWithFrame:CGRectMake(0, 480-20-44, 320, 134)];
        emojiView.delegate = self;
        [self.view addSubview:emojiView];
    }
    
    if (isEmojiPoped) {
        [self hideEj];
    }else{
        [self showEj];
    }
}
@end
