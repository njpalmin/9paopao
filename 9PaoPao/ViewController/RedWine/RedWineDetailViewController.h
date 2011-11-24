//
//  RedWineDetailViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedWineInfoView.h"
#import "ToolBarView.h"
#import "MapIconView.h"

@interface RedWineDetailViewController : UIViewController <MapIconViewDelegate, ToolBarViewDelegate, 
UITableViewDelegate, UITableViewDataSource>{

	UITableView     *mTableView;
    UIView          *mHeaderView;
	UIView			*mFooterView;
    UIButton        *mCollectionBtn;
    
    RedWineInfoView *mRedWineBasicInfo;
    ToolBarView     *mToolBarView;
    MapIconView     *mMapView;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareHeaderView;
- (BOOL)prepareFooterView;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;

@end
