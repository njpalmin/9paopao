//
//  PaoPaoRoundButton.m
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PaoPaoRoundButton.h"
#import "PaoPaoGraphicsUtility.h"

#define kLabelHeight        21.0

@implementation PaoPaoRoundButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        BOOL succeed = NO;
        
        do {
            mLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            break_if(mLabel == nil);
            
            mLabel.font = [UIFont boldSystemFontOfSize:15.0];
            mLabel.textAlignment = UITextAlignmentCenter;
            mLabel.textColor = [UIColor whiteColor];
            mLabel.highlightedTextColor = [UIColor grayColor];
            mLabel.backgroundColor = [UIColor clearColor];
            
            [self addSubview:mLabel];
            
            [self layoutSubviews];
            
            succeed = YES;
            
        } while (0);
        
        if (!succeed)
        {
            [self release];
            self = nil;
        }
    }
    return self;
}

- (void)dealloc
{
    [mLabel release];
    mLabel = nil;
    [mTouchPoint release];
    mTouchPoint = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setTitle:(NSString*)title
{
    mLabel.text = title;
}

- (void)setTarget:(id)target action:(SEL)action
{
    mTarget = target;
    mAction = action;
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews
{
    CGRect bounds;
    CGRect labelFrame;
    
    bounds = [self bounds];
    
    labelFrame.size.width = MAX(20.0, bounds.size.width - 20.0);
    labelFrame.size.height = kLabelHeight;
    
    labelFrame.origin.x = floorf((bounds.size.width - labelFrame.size.width) / 2.0);
    labelFrame.origin.y = floorf((bounds.size.height - labelFrame.size.height) / 2.0);
    
    [mLabel setFrame:labelFrame];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (mFlags.mHighlighted != highlighted)
    {
        mFlags.mHighlighted = highlighted;
        [mLabel setHighlighted:highlighted];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = NULL;
    CGRect boxRect;
    
    do {
        context = UIGraphicsGetCurrentContext();
        break_if(context == NULL);
        
        boxRect = CGRectInset([self bounds], 1.0, 1.0);
        
        if (mFlags.mHighlighted)
        {
            CGContextSetGrayFillColor(context, 1.0, 1.0);
            PPGraphicsFillRoundedRect(context, boxRect, 7.0);
        }
        else
        {
            CGContextSetGrayStrokeColor(context, 1.0, 1.0);
            CGContextSetLineWidth(context, 2.0);
            PPGraphicsStrokeRoundedRect(context, boxRect, 7.0);
        }
        
    } while (0);
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSSet *allTouches = nil;
    UITouch *touch = nil;
    CGPoint point;
    
    [mTouchPoint release];
    mTouchPoint = nil;
    
    do {
        allTouches = [event allTouches];
        break_if(allTouches == nil);
        
        break_if([allTouches count] != 1);
        
        touch = [allTouches anyObject];
        break_if(touch == nil);
        
        point = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, point))
        {
            mTouchPoint = [[PaoPaoTouchPoint alloc] initWithPoint:point];
            break_if(mTouchPoint == nil);
        }
        
    } while (0);
    
    [self setHighlighted:(mTouchPoint != nil)];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSSet *allTouches = nil;
    UITouch *touch = nil;
    BOOL succeed = NO;
    
    do {
        break_if(mTouchPoint == nil);
        
        allTouches = [event allTouches];
        break_if(allTouches == nil);
        
        break_if([allTouches count] != 1);
        
        touch = [allTouches anyObject];
        break_if(touch == nil);
        
        break_if(!CGPointEqualToPoint([touch previousLocationInView:self], [mTouchPoint currentPoint]));
        
        [mTouchPoint setCurrentPoint:[touch locationInView:self]];
        
        break_if(!CGRectContainsPoint(self.bounds, [mTouchPoint currentPoint]));
        
        succeed = YES;
        
    } while (0);
    
    if (!succeed)
    {
        [mTouchPoint release];
        mTouchPoint = nil;
    }
    
    [self setHighlighted:(mTouchPoint != nil)];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    NSSet *allTouches = nil;
    UITouch *touch = nil;
    BOOL sendAction = NO;
    
    do {
        break_if(mTouchPoint == nil);
        
        allTouches = [event allTouches];
        break_if(allTouches == nil);
        
        break_if([allTouches count] != 1);
        
        touch = [allTouches anyObject];
        break_if(touch == nil);
        
        sendAction = CGRectContainsPoint(self.bounds, [touch locationInView:self]);
        
    } while (0);
    
    [self setHighlighted:NO];
    
    [mTouchPoint release];
    mTouchPoint = nil;
    
    if (sendAction)
    {
        if (mTarget != nil && mAction != NULL)
        {
            [mTarget performSelector:mAction];
        }
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self setHighlighted:NO];    
    [mTouchPoint release];
    mTouchPoint = nil;
}

@end
