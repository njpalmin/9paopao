//
//  RedWineCategoryViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RedWineCategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView         *mTableView;
    NSMutableArray      *mCategorys;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;

@end
