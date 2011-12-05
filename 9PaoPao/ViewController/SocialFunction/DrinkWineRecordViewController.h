//
//  DrinkWineRecordViewController.h
//  9PaoPao
//
//  Created by  on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
#import "MapViewController.h"
@interface DrinkWineRecordViewController : UIViewController<ToolBarViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    
    UITableView *drinkWineTableView;
    ToolBarView *toolBar;
    NSString *withFood;
    BOOL hasLocated;
    UILabel *foodLable;
    UILabel *locationLable;
    MapViewController *mapVC;
    UIActionSheet *sheetView;
    NSInteger totalSection;
}

- (id)initWithFood:(NSString *)food;

@end
