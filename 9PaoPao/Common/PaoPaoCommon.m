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
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = [self buttonFrameForText:title font:[UIFont systemFontOfSize:15.0]];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [button autorelease];
}

@end