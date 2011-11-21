//
//  PaoPaoTouchPoint.h
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaoPaoTouchPoint : NSObject {
    
    CGPoint     mStartPoint;
    CGPoint     mPrevPoint;
    CGPoint     mCurrentPoint;
}

@property (nonatomic, readonly) CGPoint startPoint;
@property (nonatomic, readonly) CGPoint prevPoint;
@property (nonatomic, readonly) CGPoint currentPoint;

- (id)initWithPoint:(CGPoint)point;
- (void)setCurrentPoint:(CGPoint)point;

@end
