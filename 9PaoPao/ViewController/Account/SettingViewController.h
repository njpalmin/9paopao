//
//  SettingViewController.h
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIScrollView     *scrollView;
    
    NSMutableArray  *sectionNames;
    NSMutableArray  *placeHolds;
    
    UITextField     *email;
    UITextField     *password;
    UITextField     *user;
    UITextField     *number;
    
    UIButton        *imageButton;
}
@property(nonatomic,retain) NSMutableArray  *sectionNames;
@property(nonatomic,retain) NSMutableArray  *placeHolds;
@end
