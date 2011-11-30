//
//  DrinkWineRecordViewController.h
//  9PaoPao
//
//  Created by  on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
@interface DrinkWineRecordViewController : UIViewController<ToolBarViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *insertArray;
    UITableView *drinkWineTableView;
    ToolBarView *toolBar;
    NSString *withFood;
}

- (id)initWithFood:(NSString *)food;

@end
