//
//  RedWineViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RedWineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
    UITableView         *mTableView;
    NSMutableArray      *mCategorys;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (NSArray *)prepareRedWineColorData;
- (NSArray *)prepareRedWinePlaceData;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;

@end
