//
//  SearchNearbyViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchNearbyViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, 
UITableViewDataSource> {
    
    UISearchBar     *mSearchBar;
    UITextField     *mTextField;
    UITableView     *mTableView;
    
    UIView          *mSearchKindView;
    UIButton        *mSearchWineBtn;
    UIButton        *mSearchPlaceBtn;
    UIButton        *mSearchUserBtn;
    
    NSMutableArray  *mWineResult;
    NSInteger       mCurSearchKind;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;
- (void)procChooseRange:(id)sender;

@end
