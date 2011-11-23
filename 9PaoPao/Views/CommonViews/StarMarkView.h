//
//  StarMarkView.h
//  9PaoPao
//
//  Created by huangjj on 11-11-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StarMarkView : UIView {
    
    UILabel     *mStarMarkLabel;
    NSInteger   mStarNum;
}

@property(nonatomic, assign)NSInteger   starNum;

- (id)initWithFrame:(CGRect)frame withStarNum:(NSInteger)starNum;

#pragma mark -
#pragma mark Public

- (void)setStarNum:(NSInteger)starNum;

@end
