//
//  StarMarkView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StarMarkView.h"

#define StarNumber          5
#define StarImagePadding    2
#define StarMarkLabelWidth  20
#define StarMarkViewHeight  13

@implementation StarMarkView

@synthesize starNum = mStarNum;

- (id)initWithFrame:(CGRect)frame withStarNum:(NSInteger)starNum
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        float       xPos = 0;
        NSInteger   totoalStar = StarNumber;
        CGRect      selfFrame;
        
        for (int i = 0; i < starNum; i++) {
            UIImage     *starImage = [[UIImage imageNamed:@"star.png"] retain];
            UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
            
            starView.frame = CGRectMake(xPos, 0, starImage.size.width, starImage.size.height);
            starView.tag = i;
            xPos += starImage.size.width + StarImagePadding;
            
            [self addSubview:starView];
            
            [starImage release];
            starImage = nil;
            
            [starView release];
            starView = nil;
        }
        
        for (int j = starNum; j < StarNumber; j++) {
            
            UIImage     *starImage = [[UIImage imageNamed:@"grey-star.png"] retain];
            UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
            
            starView.frame = CGRectMake(xPos, 0, starImage.size.width, starImage.size.height);
            starView.tag = j;
            xPos += starImage.size.width + StarImagePadding;
            
            [self addSubview:starView];

            [starImage release];
            starImage = nil;
            
            [starView release];
            starView = nil;
        }
        
        mStarMarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, StarMarkLabelWidth, StarMarkViewHeight)];
        [mStarMarkLabel setTextColor:[UIColor blackColor]];
        [mStarMarkLabel setFont:[UIFont systemFontOfSize:12.0]];
        [mStarMarkLabel setBackgroundColor:[UIColor clearColor]];
        [mStarMarkLabel setTextAlignment:UITextAlignmentCenter];
        [mStarMarkLabel setText:[NSString stringWithFormat:@"%d/%d", starNum, totoalStar]];
        [self addSubview:mStarMarkLabel];

        xPos += StarMarkLabelWidth;
        
        selfFrame = self.frame;
        selfFrame.size.width = xPos;
        selfFrame.size.height = StarMarkViewHeight;
        self.frame = selfFrame;
        self.backgroundColor = [UIColor clearColor];
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
    if (mStarMarkLabel) {
        [mStarMarkLabel release];
        mStarMarkLabel = nil;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

//设置有亮星星，灰色的星星和显示分数的label的view，其中亮星星和灰色的星星一共为5个
- (void)setDisplayScoreNumStarNum:(NSInteger)starNum
{
    for (int i = 0; i < StarNumber; i++) {
        [[self viewWithTag:i] removeFromSuperview];
    }
    
    float       xPos = 0;
    NSInteger   totoalStar = StarNumber;
    CGRect      selfFrame;
    
    mStarNum = starNum;
    
    for (int i = 0; i < starNum; i++) {
        UIImage     *starImage = [[UIImage imageNamed:@"star.png"] retain];
        UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
        
        starView.frame = CGRectMake(xPos, 0, starImage.size.width, starImage.size.height);
        starView.tag = i;
        xPos += starImage.size.width + StarImagePadding;
        
        [self addSubview:starView];
        
        [starImage release];
        starImage = nil;
        
        [starView release];
        starView = nil;
    }
    
    for (int j = starNum; j < StarNumber; j++) {
        
        UIImage     *starImage = [[UIImage imageNamed:@"grey-star.png"] retain];
        UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
        
        starView.frame = CGRectMake(xPos, 0, starImage.size.width, starImage.size.height);
        starView.tag = j;
        xPos += starImage.size.width + StarImagePadding;
        
        [self addSubview:starView];
        
        [starImage release];
        starImage = nil;
        
        [starView release];
        starView = nil;
    }
    
    [mStarMarkLabel setText:[NSString stringWithFormat:@"%d/%d", starNum, totoalStar]];
    
    xPos += StarMarkLabelWidth;
    
    selfFrame = self.frame;
    selfFrame.size.width = xPos;
    selfFrame.size.height = StarMarkViewHeight;
    self.frame = selfFrame;
}

// 设置只有亮星星的view，没有灰色的星星和分数label
- (void)setOnlyLightStar:(NSInteger)starNum
{
    for (int i = 0; i < StarNumber; i++) {
        [[self viewWithTag:i] removeFromSuperview];
    }
    
    float       xPos = 0;
    CGRect      selfFrame;
    
    mStarNum = starNum;
    
    for (int i = 0; i < starNum; i++) {
        UIImage     *starImage = [[UIImage imageNamed:@"star.png"] retain];
        UIImageView *starView = [[UIImageView alloc] initWithImage:starImage];
        
        starView.frame = CGRectMake(xPos, 0, starImage.size.width, starImage.size.height);
        starView.tag = i;
        xPos += starImage.size.width + StarImagePadding;
        
        [self addSubview:starView];
        
        [starImage release];
        starImage = nil;
        
        [starView release];
        starView = nil;
    }
    
    [mStarMarkLabel removeFromSuperview];
        
    selfFrame = self.frame;
    selfFrame.size.width = xPos;
    selfFrame.size.height = StarMarkViewHeight;
    self.frame = selfFrame;
}

@end
