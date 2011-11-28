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
#import "RedWineListViewController.h"
#import "SearchManager.h"

@interface DrinkTrackerRecordViewController : UIViewController <ToolBarViewDelegate,EmojiViewDelegate,
UIScrollViewDelegate,UITextViewDelegate, LocationManagerDelegate,UIImagePickerControllerDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SearchManagerDelegate,UINavigationControllerDelegate> {
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
    UIImageView         *firstWineView;
    UIImageView         *secondImageView;
        
    UILabel     *scoreLabel;
    UILabel     *commentsLabel;
    UISearchBar *searchbar;
    
    UILabel *sWinelabel;
    UILabel *sPlacelabel;
    UILabel *sPriceLabel;
    
    UIView          *touchView;
    BOOL            isKeyBoardUp;
    
    UITableView     *_table;
    NSMutableArray  *searchWineResult;
    NSMutableArray  *searchPlaceResult;
}
-(void)addTooBarOnKeyboard;
-(void)hideEj;
-(void)showEj;
-(void)showKeyBoard;
-(void)hideKeyBoard;
-(void)prepareCommentViewWithHeight:(CGFloat)yPosition;

-(void)presentSearchViewWithTag:(int)tag;
-(void)dismissSearchViewWithTag:(int)tag;

- (void)startSearching;

//-(UIView *)initWineInfoWithImageName:(NSString *)imageName 
//                         andWineName:(NSString *)wineName 
//                      andOriginPlace:(NSString *)place 
//                            andPrice:(NSString *)price;
//
//-(UIView *)initWineInfoWithImageName:(NSString *)imageName 
//                          andBarName:(NSString *)wineName 
//                            andPlace:(NSString *)place 
//                      andPhoneNumber:(NSString *)number;
@end
