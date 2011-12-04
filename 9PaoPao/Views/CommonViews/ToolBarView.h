//
//  ToolBarView.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-9.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToolBarViewDelegate
-(void)locateMySelf;
-(void)takePhoto;
-(void)inputPoundSign;
-(void)follow;
-(void)showEmotion;
@end

@interface ToolBarView : UIView {
    UIButton *locationButton;
    UIButton *photoButton;
    UIButton *poundSignButton;
    UIButton *followButton;
    UIButton *emotionButton;
    id       delegate;
    
}
@property (nonatomic, retain) id delegate;
@end
