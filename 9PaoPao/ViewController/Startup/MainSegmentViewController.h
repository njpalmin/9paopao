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
#import "AccountViewController.h"
#import "MyFriendsViewController.h"
#import "LiveFeedViewController.h"

@interface MainSegmentViewController : UIViewController <MainViewControllerDelegate>{

	NSArray                 *normalButtonImage;
	NSArray                 *chooseButtonImage;
	NSMutableArray          *mButtonArray;
	NSInteger               mChoosePageIndex;   //0~5
    UIView                  *mSegementView;
    
	UINavigationController		*mHomeNavigationController;
	UINavigationController		*mLiveNavigationController;
	UINavigationController		*mProfileNavigationController;
	UINavigationController		*mFriendNavigationController;
    UINavigationController      *mSearchNavigationController;
    UINavigationController      *mLiveFeedNavigationController;

    SearchNearbyViewController  *mSearchNearbyViewController;
    MainViewController          *mMainViewController;
    AccountViewController       *mAccountViewController;
    MyFriendsViewController     *mMyFriendsViewController;
    LiveFeedViewController      *mLiveFeedViewController;
}

@property(nonatomic, assign)NSInteger choosePageIndex;

#pragma mark -
#pragma mark Public

- (void)displayViewControllerWithIndex:(NSInteger)index;

@end
