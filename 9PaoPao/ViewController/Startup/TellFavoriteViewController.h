//
//  TellFavoriteViewController.h
//  9PaoPao
//
//  Created by quanhong ma on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TellFavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    UILabel *titleLabel;
    UITableView *favoriteTable;
    //展示的内容
    NSArray *contentArray;
    NSString *navTitle;
}
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UITableView *favoriteTable;
@property(nonatomic,retain) NSArray *contentArray;
@property(nonatomic,copy)   NSString *navTitle;

- (id)initWithContentDic:(NSArray *)array;
@end
