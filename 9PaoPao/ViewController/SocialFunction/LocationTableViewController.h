//
//  LocationTableViewController.h
//  9PaoPao
//
//  Created by  on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *searchBar;
    UITableView *locationTable;
    NSString *keyText;
    NSMutableArray *showArray;
}

- (id)initWithShowContentArray:(NSArray *)array;
@end
