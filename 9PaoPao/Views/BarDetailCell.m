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
        barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, barIcon.size.width , frame.size.height - 3)];
        barImageView.image = barIcon;
        [barIcon release];
        [self.contentView addSubview:barImageView];
        
        barNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(barImageView.frame.origin.x + barImageView.frame.size.width, barImageView.frame.origin.y, frame.size.width - (barImageView.frame.origin.x + barImageView.frame.size.width), 30)];
        [self.contentView addSubview:barNameLabel];
        
        commentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, barNameLabel.frame.origin.y + barNameLabel.frame.size.height + 1, barNameLabel.frame.size.width, 30)];
        [self.contentView addSubview:commentTimeLabel];
        
        userNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, commentTimeLabel.frame.origin.y + commentTimeLabel.frame.size.height + 1, barNameLabel.frame.size.width, 30)];
        [self.contentView addSubview:userNickNameLabel];
        
        commentMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, userNickNameLabel.frame.origin.y + userNickNameLabel.frame.size.height + 1, barNameLabel.frame.size.width, 30)];
        [self.contentView addSubview:commentMarkLabel];
        
        markView = [[UIView alloc] initWithFrame:CGRectMake(barNameLabel.frame.origin.x, commentMarkLabel.frame.origin.y + commentMarkLabel.frame.size.height + 1, barNameLabel.frame.size.width, 30)];
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
