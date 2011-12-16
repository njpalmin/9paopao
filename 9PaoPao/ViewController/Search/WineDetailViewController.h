//
//  WineDetailViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapIconView.h"
#import "ToolBarView.h"
#import "EmojiView.h"
#import "LocationManager.h"
#import "ScoreView.h"
#import "WineDetailInfo.h"

@interface WineDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource
, UIImagePickerControllerDelegate, MapIconViewDelegate,ToolBarViewDelegate,EmojiViewDelegate,
UIScrollViewDelegate,UITextViewDelegate, LocationManagerDelegate,UINavigationControllerDelegate> {

	UITableView		*mTableView;
	UIView			*mFooterView;
	CGFloat			mFooterHeight;
	UIImageView		*mUploadImage;
    
    UITextView			*commentsText;
    ToolBarView			*toolBarView;
    EmojiView			*emojiView;
    ScoreView           *scoreView;
    BOOL				isEmojiPoped;
	LocationManager		*mLocationManager;
    
    CGFloat             commentsHeight;
    WineDetailInfo      *mWineDetailInfo;
}

@property(nonatomic, retain)WineDetailInfo      *wineDetailInfo;

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareFooterView;

-(void)prepareCommentViewOnView:(UIView *)footView withHeight:(CGFloat)yPos;

-(void)addTooBarOnKeyboard;
-(void)hideEj;
-(void)showEj;
-(void)showKeyBoard;
-(void)hideKeyBoard;
@end
