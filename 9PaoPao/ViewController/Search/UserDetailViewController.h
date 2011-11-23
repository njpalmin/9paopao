//
//  UserDetailViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
 
    UITableView     *mTableView;
    UIView          *mHeaderView;
    UIButton        *mAttentionBtn;
    UIButton        *mChatBtn;
    NSArray         *mMarkRecords;
}

@property(nonatomic, retain)NSArray *markRecords;

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareHeaderView;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;
- (void)procAttentionBtn:(id)sender;
- (void)procChatBtn:(id)sender;

@end
