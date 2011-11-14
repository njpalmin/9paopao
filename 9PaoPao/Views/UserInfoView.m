//
//  UserInfoView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoView.h"
#import "PaoPaoConstant.h"

#define NickNameLabelTag    200
#define IntegralLabelTag    201
#define LevelLabelTag       202
#define DescriptionLabelTag 203
#define FansLabelTag        204

@implementation UserInfoView

@synthesize userInfos = mUserInfos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *userView = nil;
        UIImage		*userImage = nil;
        CGFloat     xPos = 0;
        
        userImage = [UIImage imageNamed:@"friends-icon-bg.png"];
        userView = [[[UIImageView alloc] initWithImage:userImage] autorelease];
        userView.frame = CGRectMake(xPos, 10, userImage.size.width, userImage.size.height);
        
        [self addSubview:userView];
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
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setUserInfos:(NSArray *)userInfos
{
    if (mUserInfos) {
        [mUserInfos release];
        mUserInfos = nil;
    }

    mUserInfos = [userInfos retain];
    
    [[self viewWithTag:NickNameLabelTag] removeFromSuperview];
    [[self viewWithTag:IntegralLabelTag] removeFromSuperview];
    [[self viewWithTag:LevelLabelTag] removeFromSuperview];
    [[self viewWithTag:DescriptionLabelTag] removeFromSuperview];
    [[self viewWithTag:FansLabelTag] removeFromSuperview];

    UILabel     *nickName = nil;
    UILabel     *integral = nil;
    UILabel     *level = nil;
    UILabel     *description = nil;
    UILabel     *fans = nil;
    CGFloat		yPos = 10;
    
    nickName = [[[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)] autorelease];
    [nickName setTextColor:[UIColor blackColor]];
    [nickName setFont:[UIFont systemFontOfSize:13.0]];
    [nickName setBackgroundColor:[UIColor clearColor]];
    [nickName setTag:NickNameLabelTag];
    [self addSubview:nickName];
    
    yPos += WineDetailInfoLabelHeight;
    
    integral = [[[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)] autorelease];
    [integral setTextColor:[UIColor blackColor]];
    [integral setFont:[UIFont systemFontOfSize:13.0]];
    [integral setBackgroundColor:[UIColor clearColor]];
    integral.tag = IntegralLabelTag;
    [self addSubview:integral];
    
    yPos += WineDetailInfoLabelHeight;
    
    level = [[[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)] autorelease];
    [level setTextColor:[UIColor blackColor]];
    [level setFont:[UIFont systemFontOfSize:13.0]];
    [level setBackgroundColor:[UIColor clearColor]];
    level.tag = LevelLabelTag;
    [self addSubview:level];
    
    yPos += WineDetailInfoLabelHeight;
    
    description = [[[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)] autorelease];
    [description setTextColor:[UIColor blackColor]];
    [description setFont:[UIFont systemFontOfSize:13.0]];
    [description setBackgroundColor:[UIColor clearColor]];
    description.tag = DescriptionLabelTag;
    [self addSubview:description];
    
    yPos += WineDetailInfoLabelHeight;
    

    fans = [[[UILabel alloc] initWithFrame:CGRectMake(RightContentXOrigin, yPos, WineDetailInfoLabelWidth, WineDetailInfoLabelHeight)] autorelease];
    [fans setTextColor:[UIColor blackColor]];
    [fans setFont:[UIFont systemFontOfSize:13.0]];
    [fans setBackgroundColor:[UIColor clearColor]];
    fans.tag = FansLabelTag;
    [self addSubview:fans];
    
    yPos += WineDetailInfoLabelHeight;
    
    [nickName setText:@"昵称：张三"];
    [integral setText:@"积分：+20"];
    [level setText:@"级别："];
    [description setText:@"描述：尉迟张三"];
    [fans setText:@"粉丝：256"];

    [self addSubview:nickName];
    [self addSubview:integral];
    [self addSubview:level];
    [self addSubview:description];
    [self addSubview:fans];

    CGRect  selfFrame;
    selfFrame = self.frame;
    
    selfFrame.size.height = yPos;
    self.frame = selfFrame;
}

@end
