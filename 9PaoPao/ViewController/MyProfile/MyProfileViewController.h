//
//  MyProfileViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"

#define SelectTabDrinkTracker           3
#define SelectTabComment                5
#define SelectTabCollection             7

@interface MyProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    UserInfoView    *mUserInfoView;
    UITableView     *mTableView;
    
    UIView          *mTabSelectView;
    UIButton        *mDrinkTrackerBtn;
    UIButton        *mCommentBtn;
    UIButton        *mCollectionBtn;
    NSInteger       mCurSelectTab;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareTabSelectView;

#pragma mark -
#pragma mark Action

- (void)procEdit:(id)sender;
- (void)procSearchTabBtn:(id)sender;

@end
