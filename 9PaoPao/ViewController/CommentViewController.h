//
//  CommentViewController.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"

@interface CommentViewController : UIViewController <ToolBarViewDelegate,UIScrollViewDelegate,UITextViewDelegate> {
    UIScrollView  *scrollView;
    UITextView    *commentsText;
}
-(void)addTooBarOnKeyboard;
@end
