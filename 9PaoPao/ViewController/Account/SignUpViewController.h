//
//  SignUpViewController.h
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchManager.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate,SearchManagerDelegate> {
    UITextField     *emailTop;
    UITextField     *password;
    UITextField     *emailBottom;
    
    UIScrollView    *scrollView;
}

@end
