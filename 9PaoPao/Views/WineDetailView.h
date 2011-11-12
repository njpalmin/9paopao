//
//  WineDetailView.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineDetailView : UITableViewCell {
	
	UILabel		*mWineName;
	UILabel		*mWineProductDay;
	UILabel		*mWineProductPlace;
	UILabel		*mWineKind;
	UILabel		*mWinePrice;
}

#pragma mark -
#pragma mark Public

-(void)setWineDetailRecord;

@end
