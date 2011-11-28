//
//  AccountViewController.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-25.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UITableView        *_table;
    
    NSMutableArray     *imageArray;
    NSMutableArray     *titleArray;
    NSMutableArray     *viewControllers;
}

@end
