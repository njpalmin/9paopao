//
//  DrinkTrackerRecordViewController.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-22.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
#import "EmojiView.h"
#import "LocationManager.h"
#import "ScoreView.h"

@interface DrinkTrackerRecordViewController : UIViewController <ToolBarViewDelegate,EmojiViewDelegate,
UIScrollViewDelegate,UITextViewDelegate, LocationManagerDelegate,UIImagePickerControllerDelegate> {
    UIScrollView		*scrollView;
    UITextView			*commentsText;
    
    ToolBarView			*toolBarView;
    EmojiView			*emojiView;
    BOOL				isEmojiPoped;
	LocationManager		*mLocationManager;
    ScoreView           *scoreView;
    
    UIButton            *placeBtn;
    UIButton            *drinkBtn;
    
    CGFloat             yHeight;
}
-(void)addTooBarOnKeyboard;
-(void)hideEj;
-(void)showEj;
-(void)showKeyBoard;
-(void)hideKeyBoard;
-(void)prepareCommentViewWithHeight:(CGFloat)yPosition;

-(void)presentSearchViewWithTitle:(NSString *)title;

-(UIView *)initWineInfoWithImageName:(NSString *)imageName 
                         andWineName:(NSString *)wineName 
                      andOriginPlace:(NSString *)place 
                            andPrice:(NSString *)price;

-(UIView *)initWineInfoWithImageName:(NSString *)imageName 
                          andBarName:(NSString *)wineName 
                            andPlace:(NSString *)place 
                      andPhoneNumber:(NSString *)number;
@end
