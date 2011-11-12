//
//  SearchNearbyViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverPickerViewController.h"

@interface SearchNearbyViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, 
UITableViewDataSource, PopoverPickerViewControllerDelegate> {
    
    UISearchBar     *mSearchBar;
    UITextField     *mTextField;
    UITableView     *mTableView;
    
    UIView          *mSearchKindView;
    UIButton        *mSearchWineBtn;
    UIButton        *mSearchPlaceBtn;
    UIButton        *mSearchUserBtn;
    
    NSMutableArray  *mWineResult;
    NSInteger       mCurSearchKind;
    
    PopoverPickerViewController     *mPickerViewController;
    NSInteger						mSearchRange;
    NSArray							*mRangeArray;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareSearchKindView;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;
- (void)procChooseRange:(id)sender;

@end
