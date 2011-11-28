//
//  PopoverPickerViewController.m
//  9PaoPao
//
//  Created by huangjj on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PopoverPickerViewController.h"

@implementation PopoverPickerViewController

@synthesize delegate = mDelegate;
@synthesize chooseIndex = mChooseIndex;
@synthesize pickerContent = mPickerContents;

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
    mDelegate = nil;
    
    if (mPickerContents) {
        [mPickerContents release];
        mPickerContents = nil;
    }
    
    if (mPicker) {
        [mPicker release];
        mPicker = nil;
    }
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
        
    CGRect  pickerFrame;
    
    pickerFrame.origin.x = 0;
    pickerFrame.origin.y = 0;
    pickerFrame.size.width = 320;
    pickerFrame.size.height = 220;
    
    UIActionSheet  *actionSheet;

	actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    mPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    mPicker.showsSelectionIndicator = YES;
    [mPicker setBackgroundColor:[UIColor clearColor]];
    mPicker.delegate = self;
    mPicker.dataSource = self;
    
    [actionSheet addSubview:mPicker];
    [actionSheet showInView:self.view];
    
    [actionSheet release];
    actionSheet = nil;
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
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [mDelegate popoverPickerViewControllerDismiss:self];
}

#pragma mark -
#pragma mark PickerData Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [mPickerContents count];
}

#pragma mark -
#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mPickerContents objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    mChooseIndex = row;
    [mDelegate popoverPickerViewControllerDidSelect:self];
}

@end
