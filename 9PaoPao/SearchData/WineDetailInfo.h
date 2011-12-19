//
//  WineDetailInfo.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryInfo.h"
#import "WineryInfo.h"
#import "RegionInfo.h"

@interface WineDetailInfo : NSObject {

	NSInteger	wineCache;
	NSString	*wineId;
	CGFloat		wineScore;
	NSString	*wineType;
	NSString	*wineRefid;
	NSString	*wineTitle;
	NSString	*wineYear;
    NSString    *wineCreatDate;
	CountryInfo	*wineCountry;
	WineryInfo	*wineWinery;
	RegionInfo	*wineRegion;
}

@property(nonatomic, assign)NSInteger	wineCache;
@property(nonatomic, retain)NSString	*wineId;
@property(nonatomic, assign)CGFloat	wineScore;
@property(nonatomic, retain)NSString	*wineType;
@property(nonatomic, retain)NSString	*wineRefid;
@property(nonatomic, retain)NSString	*wineTitle;
@property(nonatomic, retain)NSString	*wineYear;
@property(nonatomic, retain)NSString    *wineCreatDate;
@property(nonatomic, retain)CountryInfo	*wineCountry;
@property(nonatomic, retain)WineryInfo	*wineWinery;
@property(nonatomic, retain)RegionInfo	*wineRegion;

-(id)initWithCache:(NSInteger)cache wineId:(NSString *)wineid score:(CGFloat)score 
			  type:(NSString *)type refid:(NSString *)refid title:(NSString *)title
			  year:(NSString *)year;
@end
