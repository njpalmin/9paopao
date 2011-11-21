//
//  PaoPaoProgressView.h
//  9PaoPao
//
//  Created by huangjj on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaoPaoRoundButton.h"

@interface PPProgressFrameView : UIView {
    
}
@end
    
@interface PaoPaoProgressView : UIView {
    
    UIActivityIndicatorView     *mIndicator;
    UILabel                     *mLabel;
    PPProgressFrameView         *mHoverView;
    PaoPaoRoundButton           *mButton;
    id                          mCancelTarget;
    SEL                         mCancelAction;
	BOOL						mNoCancel;
}

@property (nonatomic, readonly) UIActivityIndicatorView *indicator;
@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, readonly) PaoPaoRoundButton *button;
@property (nonatomic, assign)	BOOL noCancel;

#pragma mark -
#pragma mark Public

- (void)setCancelTarget:(id)target action:(SEL)action;

#pragma mark -
#pragma mark Private

- (BOOL)prepareView;
- (void)layoutSubviewsForNoCancel;

@end
