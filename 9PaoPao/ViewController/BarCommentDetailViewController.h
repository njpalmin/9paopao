//
//  BarCommentDetailViewController.h
//  9PaoPao
//
//  Created by  on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BarComment;
@interface BarCommentDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *barCommentTableView;
    BarComment * commentObject;
}

- (id)initControllerWithBarCommentObject:(BarComment *)object;

@end
