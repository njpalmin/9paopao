//
//  RedWineInfoView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RedWineInfoView.h"
#import "PaoPaoConstant.h"

@implementation RedWineInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat			xPos = 10;
        CGFloat			yPos = 5;

        UIImage     *image = nil;
		
		image = [UIImage imageNamed:@"wine-icon-bg.png"];
		mRedWineView = [[UIImageView alloc] initWithImage:image];
		mRedWineView.frame = CGRectMake(xPos, yPos+5, image.size.width, image.size.height);

        xPos += image.size.width+10;
        mBasicInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 230, 6*WineDetailInfoLabelHeight)];
        [mBasicInfoLabel setTextColor:[UIColor blackColor]];
        [mBasicInfoLabel setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [mBasicInfoLabel setBackgroundColor:[UIColor clearColor]];
        [mBasicInfoLabel setText:[NSString stringWithFormat:@"红酒名称：%@\n参考年份：%@\n产地：%@\n酒精含量：%@\n价格：%@", @"红酒", @"2002年", @"美国", @"20%", @"350元"]];
        mBasicInfoLabel.numberOfLines = 5;
        
        xPos = 15;
        yPos += 6*WineDetailInfoLabelHeight;
        mMarkTitle = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 70, 2.5*WineDetailInfoLabelHeight)];
        [mMarkTitle setTextColor:[UIColor blackColor]];
        [mMarkTitle setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [mMarkTitle setBackgroundColor:[UIColor clearColor]];
        [mMarkTitle setText:[NSString stringWithString:@"专家评分：\n总体评分："]];
        mMarkTitle.numberOfLines = 2;

        xPos += 70;
        mExpertMarkView = [[StarMarkView alloc] initWithFrame:CGRectMake(xPos, yPos+2, 0, 0) withStarNum:4];
        [mExpertMarkView setOnlyLightStar:4];
        
        yPos += mExpertMarkView.frame.size.height;
        mOverallMarkView = [[StarMarkView alloc] initWithFrame:CGRectMake(xPos, yPos+7, 0, 0) withStarNum:4];

        xPos += mOverallMarkView.frame.size.width;
        mThumbMarkView = [[ThumbMarkView alloc] initWithFrame:CGRectMake(xPos, yPos-5, 0, 0) withGoodNum:10 withBadNum:0];

        xPos = 15;
        yPos += mThumbMarkView.frame.size.height;
        mRecommendTitle = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 230, 2*WineDetailInfoLabelHeight)];
        [mRecommendTitle setTextColor:[UIColor blackColor]];
        [mRecommendTitle setFont:[UIFont fontWithName:PaoPaoFont size:16.0]];
        [mRecommendTitle setBackgroundColor:[UIColor clearColor]];
        [mRecommendTitle setText:NSLocalizedString(@"Quote Recommend:", nil)];
        
        yPos += 2*WineDetailInfoLabelHeight;
        mRecommendContent = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, 230, 5*WineDetailInfoLabelHeight)];
        [mRecommendContent setTextColor:[UIColor blackColor]];
        [mRecommendContent setFont:[UIFont fontWithName:PaoPaoFont size:13.0]];
        [mRecommendContent setBackgroundColor:[UIColor clearColor]];
        [mRecommendContent setText:[NSString stringWithFormat:@"心情：%@\n天气：%@\n场合：%@\n美食搭配：%@", @"开心", @"春夏季/阳光明媚", @"适合每天饮用(慎量)", @"鸡肉与鱼肉"]];
        mRecommendContent.numberOfLines = 4;
        
        [self addSubview:mRedWineView];
        [self addSubview:mBasicInfoLabel];
        [self addSubview:mMarkTitle];
        [self addSubview:mExpertMarkView];
        [self addSubview:mOverallMarkView];
        [self addSubview:mThumbMarkView];
        [self addSubview:mRecommendTitle];
        [self addSubview:mRecommendContent];

        yPos += 5*WineDetailInfoLabelHeight;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    if (mRedWineView) {
        [mRedWineView release];
        mRedWineView = nil;
    }
    
    if (mBasicInfoLabel) {
        [mBasicInfoLabel release];
        mBasicInfoLabel = nil;
    }
    
    if (mMarkTitle) {
        [mMarkTitle release];
        mMarkTitle = nil;
    }
    
    if (mExpertMarkView) {
        [mExpertMarkView release];
        mExpertMarkView = nil;
    }

    if (mOverallMarkView) {
        [mOverallMarkView release];
        mOverallMarkView = nil;
    }
    
    if (mThumbMarkView) {
        [mThumbMarkView release];
        mThumbMarkView = nil;
    }
    
    if (mRecommendTitle) {
        [mRecommendTitle release];
        mRecommendTitle = nil;
    }
    
    if (mRecommendContent) {
        [mRecommendContent release];
        mRecommendContent = nil;
    }
    
    [super dealloc];
}

@end
