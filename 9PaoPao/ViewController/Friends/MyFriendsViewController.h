//
//  MyFriendsViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverPickerViewController.h"
#import "UserResultViewCell.h"
#import "PaoPaoProgressView.h"
#import "SearchManager.h"
#import "UserResultViewCell.h"

@interface MyFriendsViewController : UIViewController <UITableViewDelegate, 
UITableViewDataSource, PopoverPickerViewControllerDelegate, UserResultViewCellDelegate, 
UserResultViewCellDelegate, UISearchBarDelegate> {
    
    UISearchBar     *mSearchBar;
    UITableView     *mTableView;
    
    UIView          *mFuncKindView;
    UIButton        *mSearchBtn;
    UIButton        *mAddBtn;
    
	NSMutableArray	*mUserResult;
    NSInteger       mCurFuncKind;
    NSArray         *mImageNames;
    NSArray         *mAddCellTitle;
    
    PopoverPickerViewController     *mPickerViewController;
    NSInteger						mSearchRange;
    NSArray							*mRangeArray;
    UIView                          *mSearchCancelView;
    PaoPaoProgressView              *mProgressView;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareFuncKindView;
- (void)prepareProgressView;
- (void)startSearching;

#pragma mark -
#pragma mark Action

- (void)procChooseRange:(id)sender;
- (void)procFuncKindBtn:(id)sender;
- (void)procProgressViewCancel:(id)sender;

@end
