//
//  CommentViewController.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
#import "EmojiView.h"
#import "LocationManager.h"

@interface CommentViewController : UIViewController <ToolBarViewDelegate,EmojiViewDelegate,
UIScrollViewDelegate,UITextViewDelegate, LocationManagerDelegate> {
    UIScrollView		*scrollView;
    UITextView			*commentsText;
    
    ToolBarView			*toolBarView;
    EmojiView			*emojiView;
    BOOL				isEmojiPoped;
	LocationManager		*mLocationManager;
}
-(void)addTooBarOnKeyboard;
-(void)hideEj;
-(void)showEj;
-(void)showKeyBoard;
-(void)hideKeyBoard;
@end
