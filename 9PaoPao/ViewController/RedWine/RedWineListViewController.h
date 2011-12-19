//
//  RedWineListViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaoPaoProgressView.h"
#import "SearchManager.h"

@interface RedWineListViewController : UIViewController <UITableViewDelegate, 
UITableViewDataSource, UISearchBarDelegate, SearchManagerDelegate>{

    UISearchBar         *mSearchBar;
	UITableView         *mTableView;
	NSMutableArray      *mRedWineResult;
    UIView              *mSearchCancelView;
    PaoPaoProgressView  *mProgressView;

}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (void)prepareProgressView;
- (void)displayProgressView;
- (void)startRedWineSearching;
- (void)startSearchRedWineDetailInfoWithId:(NSString *)wineId;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;
- (void)procProgressViewCancel:(id)sender;

@end
