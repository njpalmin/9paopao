//
//  LatestOfferViewCell.m
//  9PaoPao
//
//  Created by  on 11/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LatestOfferViewCell.h"

@implementation LatestOfferViewCell
@synthesize latestOfferImageView;
@synthesize latestOfferTitleLabel;
@synthesize latestOfferLocationLabel;
@synthesize latestOfferCommentLabel;
@synthesize latestOfferHostLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImage *barIcon = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar-icon-bg" ofType:@"png"]];
        latestOfferImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, barIcon.size.width , barIcon.size.height)];
        latestOfferImageView.image = barIcon;
        [barIcon release];
        [self.contentView addSubview:latestOfferImageView];
        
        latestOfferTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(latestOfferImageView.frame.origin.x + latestOfferImageView.frame.size.width, latestOfferImageView.frame.origin.y, 180, 14)];
        [latestOfferTitleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [latestOfferTitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:latestOfferTitleLabel];
        
        
        latestOfferLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(latestOfferTitleLabel.frame.origin.x, latestOfferTitleLabel.frame.origin.y + latestOfferTitleLabel.frame.size.height + 1, latestOfferTitleLabel.frame.size.width, 14)];
        [latestOfferLocationLabel setFont:[UIFont systemFontOfSize:13.0]];
        [latestOfferLocationLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:latestOfferLocationLabel];
        
        latestOfferHostLabel = [[UILabel alloc] initWithFrame:CGRectMake(latestOfferTitleLabel.frame.origin.x, latestOfferLocationLabel.frame.origin.y + latestOfferLocationLabel.frame.size.height + 1, latestOfferTitleLabel.frame.size.width, 14)];
        [latestOfferHostLabel setFont:[UIFont systemFontOfSize:13.0]];
        [latestOfferHostLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:latestOfferHostLabel];
        
        latestOfferCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(latestOfferTitleLabel.frame.origin.x, latestOfferHostLabel.frame.origin.y + latestOfferHostLabel.frame.size.height + 1, latestOfferTitleLabel.frame.size.width, 14)];
        [latestOfferCommentLabel setFont:[UIFont systemFontOfSize:13.0]];
        [latestOfferCommentLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:latestOfferCommentLabel];


    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [latestOfferCommentLabel release];
    [latestOfferHostLabel release];
    [latestOfferImageView release];
    [latestOfferLocationLabel release];
    [latestOfferTitleLabel release];
    [super dealloc];
}



@end
