//
//  PaoPaoProgressView.m
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PaoPaoProgressView.h"
#import "PaoPaoGraphicsUtility.h"

#define kPadding            10.0
#define kLabelWidth         200.0
#define kLabelHeight        21.0
#define kButtonWidth        180.0
#define kButtonHeight       32.0

@implementation PPProgressFrameView

- (void)drawRect:(CGRect)rect
{
    CGRect boxRect;
    CGContextRef context = NULL;
    
    do {
        context = UIGraphicsGetCurrentContext();
        break_if(context == NULL);
        
        boxRect = CGRectInset([self bounds], 1.0f, 1.0f);
        
        CGContextSetGrayFillColor(context, 0.0, 0.625);
        PPGraphicsFillRoundedRect(context, boxRect, 10.0);
        
    } while (0);
}

@end

@implementation PaoPaoProgressView

@synthesize indicator = mIndicator;
@synthesize label = mLabel;
@synthesize button = mButton;
@synthesize noCancel = mNoCancel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        if (![self prepareView])
        {
            [self release];
            self = nil;
        }
		mNoCancel = NO;
    }
	
    return self;
}

- (void)dealloc
{
    [mIndicator release];
    mIndicator = nil;
    
    [mLabel release];
    mLabel = nil;
    
    [mHoverView release];
    mHoverView = nil;
    
    [mButton setTarget:nil action:NULL];
    [mButton release];
    mButton = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setCancelTarget:(id)target action:(SEL)action
{
    mCancelTarget = target;
    mCancelAction = action;
}

#pragma mark -
#pragma mark Action

- (void)actionCancel:(id)sender
{
    if (mCancelTarget != nil && mCancelAction != NULL)
    {
        [mCancelTarget performSelector:mCancelAction withObject:self];
    }
}

#pragma mark -
#pragma mark UIView   

- (void)layoutSubviews
{
	if (YES == mNoCancel) {
		[self layoutSubviewsForNoCancel];
	}else {
		CGRect bounds, indicatorFrame, labelFrame, buttonFrame, hoverFrame;
		CGFloat controlPartHeight;
		
		bounds = [self bounds];
		
		indicatorFrame = [mIndicator frame];
		
		// Calculate control frame
		
		controlPartHeight = CGRectGetHeight(indicatorFrame) + kPadding + kLabelHeight + kPadding + kButtonHeight;
		
		indicatorFrame.origin.x = roundf((CGRectGetWidth(bounds) - indicatorFrame.size.width) / 2.0);
		indicatorFrame.origin.y = roundf((CGRectGetHeight(bounds) - controlPartHeight) / 2.0);
		mIndicator.frame = indicatorFrame;
        
        labelFrame.size.height = kLabelHeight;
        labelFrame.size.width = kLabelWidth;
        labelFrame.origin.x = roundf((CGRectGetWidth(bounds) - labelFrame.size.width) / 2.0);
        labelFrame.origin.y = roundf(CGRectGetMaxY(indicatorFrame) + kPadding);
        mLabel.frame = labelFrame;
				
		buttonFrame.size.width = kButtonWidth;
		buttonFrame.size.height = kButtonHeight;
		buttonFrame.origin.x = roundf((CGRectGetWidth(bounds) - buttonFrame.size.width) / 2.0);
		buttonFrame.origin.y = roundf(CGRectGetMaxY(labelFrame) + kPadding);
		mButton.frame = buttonFrame;
		
		hoverFrame = CGRectUnion(CGRectUnion(indicatorFrame, labelFrame), buttonFrame);
		hoverFrame = CGRectInset(hoverFrame, -10.0, -10.0);
		mHoverView.frame = hoverFrame;
	}
}

- (void)layoutSubviewsForNoCancel
{
    CGRect bounds, indicatorFrame, labelFrame, buttonFrame, hoverFrame;
    CGFloat controlPartHeight;
    
    bounds = [self bounds];
	
    indicatorFrame = [mIndicator frame];
    
    // Calculate control frame
    
    controlPartHeight = CGRectGetHeight(indicatorFrame) + kPadding + kLabelHeight + kPadding + kButtonHeight;
    
    indicatorFrame.origin.x = roundf((CGRectGetWidth(bounds) - indicatorFrame.size.width) / 2.0);
    indicatorFrame.origin.y = roundf((CGRectGetHeight(bounds) - controlPartHeight) / 2.0) + 15;
    mIndicator.frame = indicatorFrame;
    
    labelFrame.size.height = kLabelHeight;
    labelFrame.size.width = kLabelWidth;
    labelFrame.origin.x = roundf((CGRectGetWidth(bounds) - labelFrame.size.width) / 2.0);
    labelFrame.origin.y = roundf(CGRectGetMaxY(indicatorFrame) + kPadding);
    mLabel.frame = labelFrame;
    
    buttonFrame.size.width = kButtonWidth;
    buttonFrame.size.height = kButtonHeight;
    buttonFrame.origin.x = roundf((CGRectGetWidth(bounds) - buttonFrame.size.width) / 2.0);
    buttonFrame.origin.y = roundf(CGRectGetMaxY(labelFrame) + kPadding);
    mButton.frame = buttonFrame;
    
    hoverFrame = CGRectUnion(indicatorFrame, labelFrame);
	hoverFrame.size.height += 10;
    hoverFrame = CGRectInset(hoverFrame, -10.0, -10.0);
    mHoverView.frame = hoverFrame;
}


#pragma mark -
#pragma mark Private

- (BOOL)prepareView
{
    NSAutoreleasePool       *pool = nil;
    UIActivityIndicatorView *indicatorView = nil;
    UILabel                 *label = nil;
    PaoPaoRoundButton       *button = nil;
    PPProgressFrameView     *hoverView = nil;
    BOOL                    succeed = NO;
    
    pool = [[NSAutoreleasePool alloc] init];
    
    do {

        self.autoresizesSubviews = YES;
        self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.opaque = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.125];
        self.userInteractionEnabled = YES;
        
        // Make a indicator view
        indicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        break_if(indicatorView == nil);
                
        // Make a label
        label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        break_if(label == nil);
        
        label.font = [UIFont boldSystemFontOfSize:15.0];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        
        // Make a hover view
        hoverView = [[[PPProgressFrameView alloc] initWithFrame:CGRectZero] autorelease];
        break_if(hoverView == nil);
        
        hoverView.backgroundColor = [UIColor clearColor];
        
        // Make a button
        button = [[[PaoPaoRoundButton alloc] initWithFrame:CGRectZero] autorelease];
        break_if(button == nil);
        
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:NSLocalizedString(@"Cancel", nil)];
        [button setTarget:self action:@selector(actionCancel:)];
        
        // Add sub views
        [self addSubview:hoverView];
        [self addSubview:indicatorView];
        [self addSubview:label];
        [self addSubview:button];
		
        // Completion
        mHoverView = [hoverView retain];
        mIndicator = [indicatorView retain];
        mLabel = [label retain];
        mButton = [button retain];
        
        [self layoutSubviews];
        
        succeed = YES;
        
    } while (0);
    
    [pool release];
    
    return succeed;
}

@end
