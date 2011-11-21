//
//  PaoPaoGraphicsUtility.h
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Graphics Utility

extern void
PPGraphicsFillRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);

extern void
PPGraphicsStrokeRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);

extern void
PPGraphicsAddRoundedRectPath(CGContextRef context, CGRect rect, CGFloat radius);

extern UIImage *
PPGraphicsImageNamed(NSString *name);

extern CGImageRef
PPGraphicsCreateImageWithPNGImageResourceNamed(NSString *filename);
