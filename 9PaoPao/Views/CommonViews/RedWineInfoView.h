//
//  RedWineInfoView.h
//  9PaoPao
//
//  Created by huangjj on 11-11-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarMarkView.h"
#import "ThumbMarkView.h"
#import "WineDetailInfo.h"

@interface RedWineInfoView : UIView {
    
    UIImageView     *mRedWineView;
    UILabel         *mBasicInfoLabel;
    UILabel         *mMarkTitle;
    StarMarkView    *mExpertMarkView;
    StarMarkView    *mOverallMarkView;
    ThumbMarkView   *mThumbMarkView;
    UILabel         *mRecommendTitle;
    UILabel         *mRecommendContent;
    
    WineDetailInfo  *mRedWineInfo;
}
@property(nonatomic, retain)WineDetailInfo  *redWineInfo;

@end
