//
//  LatestOfferViewController.h
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestOfferViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *latestOfferTable;
    NSArray *latestOfferArray;
}
- (id)initControllerWithArray:(NSArray *)array;
@end
