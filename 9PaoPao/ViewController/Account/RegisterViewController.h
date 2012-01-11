//
//  RegisterViewController.h
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegisterViewController : UIViewController<UIImagePickerControllerDelegate,UITextFieldDelegate,UINavigationControllerDelegate> {
    UIScrollView *scrollView;
    
    UITextField  *mail;
    UITextField  *password;
    UITextField  *nibname;
    UITextField  *phone;
    
    UIButton     *picButton;
    UIButton     *registerButton;
    UIImageView  *imageView;
}

-(void) addToolbarAboveKeyboard;
@end
