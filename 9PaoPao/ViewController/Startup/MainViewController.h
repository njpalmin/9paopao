//
//  MainViewController.h
//  9PaoPao
//
//  Created by yi xiaoluo on 11-11-8.
//  Copyright 2011年 MI2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *_table;
    NSArray *imageNames;
    NSArray *imageTitles;
    NSArray *viewControllers;
    
    NSInteger position;
    
}
@property (nonatomic, retain) UITableView *_table;
-(void)clickButtonWithTag:(NSInteger)tag;
@end
