//
//  TellFavoriteViewController.h
//  9PaoPao
//
//  Created by quanhong ma on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TellFavoriteViewControllerDelegate;

@interface TellFavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    
    id<TellFavoriteViewControllerDelegate>  mDelegate;
    UILabel                                 *titleLabel;
    UITableView                             *favoriteTable;
    
    //展示的内容
    NSArray                                 *contentArray;
    NSString                                *navTitle;
}
@property(nonatomic,assign)id<TellFavoriteViewControllerDelegate>  delegate;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UITableView *favoriteTable;
@property(nonatomic,retain) NSArray *contentArray;
@property(nonatomic,copy)   NSString *navTitle;

- (id)initWithContentDic:(NSArray *)array;
@end

@protocol TellFavoriteViewControllerDelegate <NSObject>

- (void)tellFavoriteViewControllerDidFinish:(TellFavoriteViewController *)controller;

@end