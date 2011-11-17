//
//  ThumbMarkView.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThumbMarkView.h"

#define	ThumbMarkLabelWidth			20
#define ThumbMarkLabelHeight		13
#define	ThumbMarkViewHeight			25

@implementation ThumbMarkView

@synthesize goodThumbNum = mGoodThumbNum;
@synthesize badThumbNum = mBadThumbNum;

- (id)initWithFrame:(CGRect)frame withGoodNum:(NSInteger)goodNum withBadNum:(NSInteger)badNum{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
		CGFloat		xPos = 0;
		CGSize		imageSize;
		UIImageView	*imageView = nil;
		UIImage		*image = nil;
		
		mGoodThumbNum = goodNum;
		mBadThumbNum = badNum;
		
		mTotalMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, (ThumbMarkViewHeight - ThumbMarkLabelHeight), ThumbMarkLabelWidth, ThumbMarkLabelHeight)];
        [mTotalMarkLabel setTextColor:[UIColor blackColor]];
        [mTotalMarkLabel setFont:[UIFont systemFontOfSize:12.0]];
        [mTotalMarkLabel setBackgroundColor:[UIColor clearColor]];
        [mTotalMarkLabel setTextAlignment:UITextAlignmentCenter];
        [mTotalMarkLabel setText:[NSString stringWithFormat:@"%d", mGoodThumbNum*5]];
        [self addSubview:mTotalMarkLabel];
		
		xPos += ThumbMarkLabelWidth;
		
		image = [UIImage imageNamed:@"good.png"];
		imageSize = image.size;
		
		imageView = [[UIImageView alloc] initWithImage:image];
		imageView.frame = CGRectMake(xPos, 0, imageSize.width, ThumbMarkViewHeight);
		[self addSubview:imageView];
		
		[imageView release];
		imageView = nil;
		xPos += imageSize.width;
		
		mGoodMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, (ThumbMarkViewHeight - ThumbMarkLabelHeight), ThumbMarkLabelWidth, ThumbMarkLabelHeight)];
        [mGoodMarkLabel setTextColor:[UIColor blackColor]];
        [mGoodMarkLabel setFont:[UIFont systemFontOfSize:12.0]];
        [mGoodMarkLabel setBackgroundColor:[UIColor clearColor]];
        [mGoodMarkLabel setTextAlignment:UITextAlignmentCenter];
        [mGoodMarkLabel setText:[NSString stringWithFormat:@"%d", mGoodThumbNum]];
        [self addSubview:mGoodMarkLabel];
		
		xPos += ThumbMarkLabelWidth;
		
		image = [UIImage imageNamed:@"bad.png"];
		imageSize = image.size;
		
		imageView = [[UIImageView alloc] initWithImage:image];
		imageView.frame = CGRectMake(xPos, 0, imageSize.width, ThumbMarkViewHeight);
		[self addSubview:imageView];
		
		[imageView release];
		imageView = nil;
		xPos += imageSize.width;		

		mBadMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, (ThumbMarkViewHeight - ThumbMarkLabelHeight), ThumbMarkLabelWidth, ThumbMarkLabelHeight)];
        [mBadMarkLabel setTextColor:[UIColor blackColor]];
        [mBadMarkLabel setFont:[UIFont systemFontOfSize:12.0]];
        [mBadMarkLabel setBackgroundColor:[UIColor clearColor]];
        [mBadMarkLabel setTextAlignment:UITextAlignmentCenter];
        [mBadMarkLabel setText:[NSString stringWithFormat:@"%d", mBadThumbNum]];
        [self addSubview:mBadMarkLabel];
		
		xPos += ThumbMarkLabelWidth;
		
		CGRect	selfFrame;
		
		selfFrame = frame;
		selfFrame.size = CGSizeMake(xPos, ThumbMarkViewHeight);
		self.frame = selfFrame;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	
	if (mGoodMarkLabel) {
		[mGoodMarkLabel release];
		mGoodMarkLabel = nil;
	}
	
	if (mTotalMarkLabel) {
		[mTotalMarkLabel release];
		mTotalMarkLabel = nil;
	}
	
	if (mBadMarkLabel) {
		[mBadMarkLabel release];
		mBadMarkLabel = nil;
	}
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setGoodThumbNum:(NSInteger)goodNum
{
	mGoodThumbNum = goodNum;
	[mGoodMarkLabel setText:[NSString stringWithFormat:@"%d", mGoodThumbNum]];
	[mTotalMarkLabel setText:[NSString stringWithFormat:@"%d", mGoodThumbNum*5]];
}

- (void)setBadThumbNum:(NSInteger)badNum
{
	mBadThumbNum = badNum;
	[mBadMarkLabel setText:[NSString stringWithFormat:@"%d", mBadThumbNum]];
}

@end
