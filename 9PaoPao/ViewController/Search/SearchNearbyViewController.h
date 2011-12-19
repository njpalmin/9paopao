// 
//  SearchNearbyViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverPickerViewController.h"
#import "UserResultViewCell.h"
#import "PaoPaoProgressView.h"
#import "SearchManager.h"

@interface SearchNearbyViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, 
UITableViewDataSource, PopoverPickerViewControllerDelegate, UserResultViewCellDelegate, 
UISearchBarDelegate, SearchManagerDelegate> {
    
    UISearchBar     *mSearchBar;
    UITextField     *mTextField;
    UITableView     *mTableView;
    
    UIView          *mSearchKindView;
    UIButton        *mSearchWineBtn;
    UIButton        *mSearchPlaceBtn;
    UIButton        *mSearchUserBtn;
    
    NSMutableArray  *mWineResult;
	NSMutableArray	*mPlaceResult;
	NSMutableArray	*mUserResult;
    NSInteger       mCurSearchKind;
    
    PopoverPickerViewController     *mPickerViewController;
    NSInteger						mSearchRange;
    NSArray							*mRangeArray;
    UIView                          *mSearchCancelView;
    PaoPaoProgressView              *mProgressView;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareSearchKindView;
- (void)prepareProgressView;
- (void)displayProgressView;
- (void)startSearching;
- (void)startSearchWineDetailInfoWithId:(NSString *)wineId;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;
- (void)procChooseRange:(id)sender;
- (void)procSearchKindBtn:(id)sender;
- (void)procProgressViewCancel:(id)sender;

@end
