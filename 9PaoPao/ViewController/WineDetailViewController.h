//
//  WineDetailViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapIconView.h"

@interface WineDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource
, UIImagePickerControllerDelegate, MapIconViewDelegate> {

	UITableView		*mTableView;
	UIView			*mFooterView;
	CGFloat			mFooterHeight;
	UIImageView		*mUploadImage;
}

#pragma mark -
#pragma mark Private

- (BOOL)prepareNavigationBar;
- (BOOL)prepareFooterView;

@end
