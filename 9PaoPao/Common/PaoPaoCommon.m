//
//  PaoPaoCommon.m
//  9PaoPao
//
//  Created by huangjj on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PaoPaoCommon.h"

@interface UINavigationBar (CustomImage)

- (void) drawRect: (CGRect)rect;

@end
@implementation UINavigationBar (CustomImage)

- (void) drawRect: (CGRect)rect
{
    UIImage *barImage=[UIImage imageNamed:@"header-bg.png"];
    [barImage drawInRect:rect];    
}
@end

@implementation PaoPaoCommon

+ (CGRect)buttonFrameForText:(NSString *)text font:(UIFont *)font{
    
    CGRect frame = CGRectZero;
    CGSize size = [text sizeWithFont:font];
    
    frame.size.width = size.width + 15;
    frame.size.height = size.height + 10;
    
    return frame;
}

+ (UIButton *)getBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName action:(SEL)action target:(id)target
{
    UIButton    *button = [[UIButton alloc] init];
    NSString    *normalPath = nil;
    NSString    *highlightPath = nil;
    UIImage     *normalImage = nil;
    UIImage     *highlightImage = nil;
    CGRect		buttonFrame = CGRectZero;
    
    normalPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],imageName];
    highlightPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],highlightedImageName];

    normalImage = [UIImage imageWithContentsOfFile:normalPath];
    highlightImage = [UIImage imageWithContentsOfFile:highlightPath];
    
    buttonFrame.size = normalImage.size;

    //[button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = buttonFrame;
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [button autorelease];
}

+ (UIButton *)getImageButtonWithName:(NSString *)imageName highlightName:(NSString *)highlightedImageName action:(SEL)action target:(id)target
{
    UIButton    *button = [[UIButton alloc] init];
	CGRect		buttonFrame = CGRectZero;
    NSString    *normalPath = nil;
    NSString    *highlightPath = nil;
    UIImage     *normalImage = nil;
    UIImage     *highlightImage = nil;
    
    normalPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],imageName];
    highlightPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],highlightedImageName];
    
    normalImage = [UIImage imageWithContentsOfFile:normalPath];
    highlightImage = [UIImage imageWithContentsOfFile:highlightPath];

	buttonFrame.size = normalImage.size;
    button.frame = buttonFrame;
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [button autorelease];
}
@end