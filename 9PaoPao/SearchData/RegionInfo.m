//
//  RegionInfo.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegionInfo.h"


@implementation RegionInfo

@synthesize regionCache, regionId, regionType, regionRefid, regionTitle, regionCountry;

- (void)dealloc
{
	[regionId release];
	regionId = nil;
	
	[regionType release];
	regionType = nil;
	
	[regionRefid release];
	regionRefid = nil;
	
	[regionTitle release];
	regionTitle = nil;
	
	[regionCountry release];
	regionCountry = nil;
	
    [super dealloc];
}

-(id)initWithCache:(NSInteger)cache regionId:(NSString *)regionid type:(NSString *)type 
			 refid:(NSString *)refid title:(NSString *)title
{
	self = [super init];
    if (self != nil)
    {
		self.regionCache = cache;
		self.regionId = regionid;
		self.regionType = type;
		self.regionRefid = refid;
		self.regionTitle = title;
	}
	return self;
}

@end
