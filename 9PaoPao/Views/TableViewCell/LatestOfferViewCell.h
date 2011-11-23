//
//  LatestOfferViewCell.h
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestOfferViewCell : UITableViewCell
{
    UIImageView *latestOfferImageView;
    UILabel *latestOfferTitleLabel;
    UILabel *latestOfferLocationLabel;
    UILabel *latestOfferHostLabel;
    UILabel *latestOfferCommentLabel;
}
@property(nonatomic,retain) UIImageView *latestOfferImageView;
@property(nonatomic,retain) UILabel *latestOfferTitleLabel;
@property(nonatomic,retain) UILabel *latestOfferLocationLabel;
@property(nonatomic,retain) UILabel *latestOfferCommentLabel;
@property(nonatomic,retain) UILabel *latestOfferHostLabel;

@end
