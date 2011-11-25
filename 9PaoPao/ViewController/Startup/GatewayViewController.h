//
//  GatewayViewController.h
//  9PaoPao
//
//  Created by huangjj on 11-11-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TellFavoriteViewController.h"

@interface GatewayViewController : UIViewController<TellFavoriteViewControllerDelegate> {
    
    UIButton                    *mMostLoveBtn;
    UIButton                    *mSearchBtn;
    UINavigationController      *mNavigationController;
}

@end
