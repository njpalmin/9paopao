//
//  AppDelegate.h
//  9PaoPao
//
//  Created by 金 里麟 on 11-11-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GatewayViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow                        *mWindow;
    GatewayViewController           *mGatewayViewController;
}
@property (retain, nonatomic) UIWindow *window;

@end
