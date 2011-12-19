//
//  WineDetailInfo.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WineDetailInfo.h"


@implementation WineDetailInfo

@synthesize wineCache, wineId, wineScore, wineType, wineRefid, wineTitle, wineYear, 
wineCreatDate, wineCountry, wineWinery, wineRegion;

- (void)dealloc
{
	[wineId release];
	wineId = nil;
	
	[wineType release];
	wineType = nil;
	
	[wineRefid release];
	wineRefid = nil;
	
	[wineTitle release];
	wineTitle = nil;
	
	[wineYear release];
	wineYear = nil;
	
    [wineCreatDate release];
    wineCreatDate = nil;
    
	[wineCountry release];
	wineCountry = nil;
	
	[wineWinery release];
	wineWinery = nil;
	
	[wineRegion release];
	wineRegion = nil;
	
    [super dealloc];
}

-(id)initWithCache:(NSInteger)cache wineId:(NSString *)wineid score:(CGFloat)score 
			  type:(NSString *)type refid:(NSString *)refid title:(NSString *)title
			  year:(NSString *)year
{
	self = [super init];
    if (self != nil)
    {
		self.wineCache = cache;
		self.wineId = wineid;
		self.wineScore = score;
		self.wineType = type;
		self.wineRefid = refid;
		self.wineTitle = title;
		self.wineYear = year;
	}
	return self;
}

@end
