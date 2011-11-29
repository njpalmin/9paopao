//
//  LineView.m
//  9PaoPao
//
//  Created by 小洛 伊 on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawLineWithMinX:0.0 MinY:0.0 MaxX:300.0 MaxY:0.0];
    
}
/*******************************************************************************
 函数名称    : drawListLineWithMinX
 函数描述    : 根据（minX,minY）(maxX,maxY)画直线
 输入参数    : 直线的端点坐标
 输出参数    : N/A
 返回值      : N/A
 备注       : N/A
 *******************************************************************************/

- (void)drawLineWithMinX:(CGFloat)minX MinY:(CGFloat)minY MaxX:(CGFloat)maxX MaxY:(CGFloat)maxY
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGContextSetRGBStrokeColor(ctx, 0.95, 0.95, 0.95, 1.0);
    CGContextSetLineWidth(ctx, 1.0);
	CGContextMoveToPoint	(ctx, minX, minY);
	CGContextAddLineToPoint	(ctx, maxX, maxY);
	CGContextStrokePath		(ctx);
}

@end
