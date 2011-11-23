//
//  ThumbMarkView.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThumbMarkView : UIView {

	UILabel		*mTotalMarkLabel;
	UILabel		*mGoodMarkLabel;
	UILabel		*mBadMarkLabel;
	
	NSInteger	mGoodThumbNum;
	NSInteger	mBadThumbNum;	
}

@property(nonatomic, assign)NSInteger goodThumbNum;
@property(nonatomic, assign)NSInteger badThumbNum;

- (id)initWithFrame:(CGRect)frame withGoodNum:(NSInteger)goodNum withBadNum:(NSInteger)badNum;

#pragma mark -
#pragma mark Public

- (void)setGoodThumbNum:(NSInteger)goodNum;
- (void)setBadThumbNum:(NSInteger)badNum;

@end
