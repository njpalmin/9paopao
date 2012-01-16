//
//  UserDetailCell.m
//  9PaoPao
//
//  Created by jj huang on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserDetailCell.h"
#import "StarMarkView.h"
#import "ThumbMarkView.h"
#import "PaoPaoCommon.h"

#define CellLeftImageTag            1000
#define CellStarMarkViewTag			1001
#define CellThumbMarkViewTag		1002

@implementation UserDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGFloat		yPos = 5;
		
		mNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)];
        [mNameLabel setTextColor:[UIColor redColor]];
        [mNameLabel setFont:[UIFont systemFontOfSize:13.0]];
        [mNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mNameLabel];
		
		yPos += WineDetailInfoLabelHeight;
		
		mCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth+20, WineDetailInfoLabelHeight*3)];
        [mCommentLabel setTextColor:[UIColor blackColor]];
        [mCommentLabel setFont:[UIFont systemFontOfSize:13.0]];
        [mCommentLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:mCommentLabel];

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
    if (mNameLabel) {
        [mNameLabel release];
        mNameLabel = nil;
    }
    
    if (mCommentLabel) {
        [mCommentLabel release];
        mCommentLabel = nil;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setUserDetailRecord
{
    [[self.contentView viewWithTag:CellLeftImageTag] removeFromSuperview];
	[[self.contentView viewWithTag:CellStarMarkViewTag] removeFromSuperview];
	[[self.contentView viewWithTag:CellThumbMarkViewTag] removeFromSuperview];
    
    UIImage     *image = nil;
	UIImageView *leftImageView = nil;
	
	image = [UIImage imageNamed:@"people-offline.png"];
	leftImageView = [[UIImageView alloc] initWithImage:image];
	leftImageView.frame = CGRectMake(8, 10, image.size.width, image.size.height);
	leftImageView.tag = CellLeftImageTag;
	
	[self.contentView addSubview:leftImageView];
	
	[leftImageView release];
	leftImageView = nil;

    CGFloat score = 4.6;
    
	StarMarkView *markView = [[StarMarkView alloc] initWithFrame:CGRectMake(RightContentXOrigin, 72, 0, 0) withStarNum:[PaoPaoCommon roundingFloat:score]];
	markView.tag = CellStarMarkViewTag;
	[self.contentView addSubview:markView];
	
	ThumbMarkView	*thumbView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(180, 60, 0, 0) withGoodNum:10 withBadNum:0];
	thumbView.tag = CellThumbMarkViewTag;
	[self.contentView addSubview:thumbView];
    
    [markView release];
	markView = nil;
	
	[thumbView release];
	thumbView = nil;
    
    //---label detail info----
    
    [mNameLabel setText:@"名称：Regment"];
    [mCommentLabel setNumberOfLines:2];
    [mCommentLabel setText:@"用户评论:sajoisahodiyahaidhhhjdoudaodg;"];
}

@end
