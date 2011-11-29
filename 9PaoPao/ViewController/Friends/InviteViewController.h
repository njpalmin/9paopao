//
//  InviteViewController.h
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBookUI/AddressBookUI.h"

@interface InviteViewController : UIViewController <UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate,UITextViewDelegate>{
    UIScrollView   *scrollView;
    
    UITextField     *toEmail;
    UITextField     *subject;
    
    UITextView      *content;
     
    NSArray  *phoneNumbers;
}

@property(nonatomic,retain) NSArray  *phoneNumbers;

-(void) addToolbarAboveKeyboard;

@end
