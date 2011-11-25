//
//  MainSegmentViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchNearbyViewController.h"
#import "MainViewController.h"

@interface MainSegmentViewController : UIViewController {

	NSArray                 *normalButtonImage;
	NSArray                 *chooseButtonImage;
	NSMutableArray          *mButtonArray;
	NSInteger               mChoosePageIndex;
    UIView                  *mSegementView;
    
	UINavigationController		*mHomeNavigationController;
	UINavigationController		*mLiveNavigationController;
	UINavigationController		*mProfileNavigationController;
	UINavigationController		*mFriendNavigationController;
    UINavigationController      *mSearchNavigationController;

    SearchNearbyViewController  *mSearchNearbyViewController;
    MainViewController          *mMainViewController;

}

@property(nonatomic, assign)NSInteger choosePageIndex;

#pragma mark -
#pragma mark Public

- (void)displayViewControllerWithIndex:(NSInteger)index;

@end
