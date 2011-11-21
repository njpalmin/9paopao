//
//  PaoPaoRoundButton.h
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaoPaoTouchPoint.h"

@interface PaoPaoRoundButton : UIView {
    
    id                  mTarget;
    SEL                 mAction;
    UILabel             *mLabel;
    
    PaoPaoTouchPoint    *mTouchPoint;
    
    struct {
        unsigned int    mHighlighted:1;
    } mFlags;
}

- (void)setTitle:(NSString*)title;
- (void)setTarget:(id)target action:(SEL)action;

@end
