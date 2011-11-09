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
//add by mqh begin 2011-11-9
#import "TellFavoriteViewController.h"
//add by mqh end   2011-11-9
@interface MainSegmentViewController : UIViewController {

	NSArray                 *normalButtonImage;
	NSArray                 *chooseButtonImage;
	NSMutableArray          *mButtonArray;
	NSInteger               mChoosePageIndex;
    UIView                  *mSegementView;
    
    UINavigationController      *mNavigationController;
    SearchNearbyViewController  *mSearchNearbyViewController;
    MainViewController          *mMainViewController;
    //add by mqh begin 2011-11-9
    TellFavoriteViewController *tFVC;
    //add by mqh end   2011-11-9
}

@property(nonatomic, assign)NSInteger choosePageIndex;
@end
