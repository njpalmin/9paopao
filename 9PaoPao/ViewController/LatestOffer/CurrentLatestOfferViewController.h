//
//  CurrentLatestOfferViewController.h
//  9PaoPao
//
//  Created by  on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MapViewController;
@class LatestOfferObject;
@interface CurrentLatestOfferViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *currentLatestOfferTableView;
    LatestOfferObject *currentLatestOffer;
    MapViewController *mVC;
}
- (id)initControllerWithCurrentLatestOffer:(LatestOfferObject *)object;
@end
