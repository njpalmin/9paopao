//
//  MainSegmentViewController.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainSegmentViewController : UIViewController {

	NSArray			*normalButtonImage;
	NSArray			*chooseButtonImage;
	NSMutableArray	*mButtonArray;
	NSInteger		mChoosePageIndex;
    UIView          *mSegementView;
}

@property(nonatomic, assign)NSInteger choosePageIndex;
@end
