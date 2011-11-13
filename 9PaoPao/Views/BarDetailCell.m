//
//  BarDetailCell.m
//  9PaoPao
//
//  Created by quanhong ma on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BarDetailCell.h"


@implementation BarDetailCell
@synthesize barImageView;
@synthesize userNickNameLabel;
@synthesize barNameLabel;
@synthesize markView;
@synthesize commentMarkLabel;
@synthesize commentTimeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect frame = self.contentView.frame;
        UIImage *barIcon = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bar-icon-bg" ofType:@"png"]];
        barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, barIcon.size.width , barIcon.size.height)];
        barImageView.image = barIcon;
        [barIcon release];
        [self.contentView addSubview:barImageView];
        
        barNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(barImageView.frame.origin.x + barImageView.frame.size.width, barImageView.frame.origin.y, 180, 14)];
        [barNameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [barNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:barNameLabel];
       
        
        commentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, barNameLabel.frame.origin.y + barNameLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [commentTimeLabel setFont:[UIFont systemFontOfSize:13.0]];
        [commentTimeLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:commentTimeLabel];
        
        userNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, commentTimeLabel.frame.origin.y + commentTimeLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [userNickNameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [userNickNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:userNickNameLabel];
        
        commentMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, userNickNameLabel.frame.origin.y + userNickNameLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [commentMarkLabel setFont:[UIFont systemFontOfSize:13.0]];
        [commentMarkLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:commentMarkLabel];
        
        markView = [[UIView alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, commentMarkLabel.frame.origin.y + commentMarkLabel.frame.size.height + 1, barNameLabel.frame.size.width, 14)];
        [self.contentView addSubview:markView];
        
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
    [barImageView release];
    [userNickNameLabel release];
    [barNameLabel release];
    [markView release];
    [commentMarkLabel release];
    [commentTimeLabel release];
    [super dealloc];
}

@end
