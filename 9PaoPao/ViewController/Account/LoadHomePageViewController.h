//
//  LoadHomePageViewController.h
//  9PaoPao
//
//  Created by YI YXL on 11-11-26.
//  Copyright 2011年 GOOLE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadHomePageViewController : UIViewController <UIWebViewDelegate>{
    UIWebView           *_webView;
    UILabel             *waitingLabel;
}

@end
