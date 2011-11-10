//
//  BarDetailViewController.h
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BarDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *barTable;
    NSArray *barArray;
}

- (id)initControllerWithArray:(NSArray *)array;

@end
