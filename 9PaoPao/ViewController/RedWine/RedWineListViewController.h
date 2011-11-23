//
//  RedWineListViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RedWineListViewController : UIViewController <UITableViewDelegate, 
UITableViewDataSource>{

	UITableView     *mTableView;
	NSMutableArray  *mRedWineResult;

}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;

#pragma mark -
#pragma mark Action

- (void)procReturn:(id)sender;

@end
