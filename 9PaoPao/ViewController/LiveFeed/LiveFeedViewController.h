//
//  LiveFeedViewController.h
//  9PaoPao
//
//  Created by 小洛 伊 on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveFeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView       *_table;
    
    NSMutableArray    *sectionTitles;
    
}
@property (nonatomic,retain)  NSMutableArray   *sectionTitles;

@end
