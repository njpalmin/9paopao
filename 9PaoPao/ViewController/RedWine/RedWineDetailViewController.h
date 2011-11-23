//
//  RedWineDetailViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RedWineDetailViewController : UIViewController {

	UITableView     *mTableView;
    UIView          *mHeaderView;
	UIView			*mFooterView;
    UIButton        *mCollectionBtn;
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
