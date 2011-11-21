//
//  PaoPaoTouchPoint.m
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PaoPaoTouchPoint.h"


@implementation PaoPaoTouchPoint

@synthesize startPoint = mStartPoint;
@synthesize prevPoint = mPrevPoint;
@synthesize currentPoint = mCurrentPoint;

- (id)initWithPoint:(CGPoint)point
{
    self = [super init];
    if (self != nil)
    {
        mStartPoint = point;
        mPrevPoint = point;
        mCurrentPoint = point;
    }
    return self;
}

- (void)setCurrentPoint:(CGPoint)point
{
    mPrevPoint = mCurrentPoint;
    mCurrentPoint = point;
}

@end
