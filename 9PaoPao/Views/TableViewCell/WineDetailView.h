//
//  WineDetailView.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineDetailInfo.h"

@interface WineDetailView : UITableViewCell {
	
	UILabel		*mWineName;
	UILabel		*mWineProductDay;
	UILabel		*mWineProductPlace;
	UILabel		*mWineKind;
	UILabel		*mWinePrice;
    
    WineDetailInfo  *wineDetailInfo;
}

@property(nonatomic, retain)WineDetailInfo  *wineDetailInfo;
@property(nonatomic, retain)UILabel		*mWineName;
@property(nonatomic, retain)UILabel		*mWineProductDay;
@property(nonatomic, retain)UILabel		*mWineProductPlace;
@property(nonatomic, retain)UILabel		*mWineKind;
@property(nonatomic, retain)UILabel		*mWinePrice;
#pragma mark -
#pragma mark Public

-(void)setWineDetailRecord:(WineDetailInfo *)wineDetail;
-(void)setPlaceDetailRecord;

#pragma mark -
#pragma mark Private

// 四舍五入
- (NSInteger)roundingFloat:(CGFloat)floatNum;

@end
