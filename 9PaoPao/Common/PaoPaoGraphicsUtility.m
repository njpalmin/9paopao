//
//  PaoPaoGraphicsUtility.m
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PaoPaoGraphicsUtility.h"

#pragma mark -
#pragma mark Draw Utility

void
PPGraphicsFillRoundedRect(CGContextRef context, CGRect rect, CGFloat radius)
{
    CGContextBeginPath(context);
    PPGraphicsAddRoundedRectPath(context, rect, radius);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

void
PPGraphicsStrokeRoundedRect(CGContextRef context, CGRect rect, CGFloat radius)
{
    CGContextBeginPath(context);
    PPGraphicsAddRoundedRectPath(context, rect, radius);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

void
PPGraphicsAddRoundedRectPath(CGContextRef context, CGRect rect, CGFloat radius)
{
    CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
}

UIImage *
PPGraphicsImageNamed(NSString *name)
{
    NSString *path = nil;
    UIImage *result = nil;
    
    do {
        path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        break_if(path == nil);
        
        result = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
        break_if(result == nil);
        
    } while (0);
    
    return result;
}

CGImageRef
PPGraphicsCreateImageWithPNGImageResourceNamed(NSString *filename)
{
    CGDataProviderRef provider = NULL;
    CGImageRef image = NULL;
    NSString *path = nil;
    
    do {
        path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        break_if(path == nil);
        
        provider = CGDataProviderCreateWithFilename((const char*)[path fileSystemRepresentation]);
        break_if(provider == NULL);
        
        image = CGImageCreateWithPNGDataProvider(provider, NULL, TRUE, kCGInterpolationDefault);
        break_if(image == NULL);
        
    } while (0);
    
    CGDataProviderRelease(provider);
    
    return image;
}
