//
//  MapIconView.h
//  9PaoPao
//
//  Created by huangjj on 11-11-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapIconViewDelegate;

@interface MapIconView : UIView {
    
	id<MapIconViewDelegate>		mDelegate;
}
@property(nonatomic, assign)id<MapIconViewDelegate>	delegate;
@end

@protocol MapIconViewDelegate <NSObject>

- (void)mapIconViewDisplayDetailMap:(MapIconView *)mapView;

@end