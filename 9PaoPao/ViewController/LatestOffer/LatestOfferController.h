//
//  LatestOfferController.h
//  9PaoPao
//
//  Created by  on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LatestOfferViewController.h"
#import "LatestOfferObject.h"
#import "CurrentLatestOfferViewController.h"
@interface LatestOfferController : UIViewController<UISearchBarDelegate>
{
    UISearchBar *searchBar;
    UIButton *currentLatestOfferBtn;
    UIButton *allLatestOfferBtn;
    LatestOfferViewController *allLatestOfferVC;
    CurrentLatestOfferViewController *currentLatestOfferVC;
}

@end
