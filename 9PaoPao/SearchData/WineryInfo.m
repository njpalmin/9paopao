//
//  WineryInfo.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WineryInfo.h"

@implementation WineryInfo

@synthesize wineryCache, wineryId, wineryRefid, wineryType,
wineryTitle, wineryCountry, wineryRegion;

- (void)dealloc
{
	[wineryId release];
	wineryId = nil;
	
	[wineryRefid release];
	wineryRefid = nil;
	
	[wineryType release];
	wineryType = nil;
	
	[wineryTitle release];
	wineryTitle = nil;
	
	[wineryCountry release];
	wineryCountry = nil;
	
	[wineryRegion release];
	wineryRegion = nil;
	
    [super dealloc];
}

-(id)initWithCache:(NSInteger)cache wineryId:(NSString *)wineryid type:(NSString *)type 
			 refid:(NSString *)refid title:(NSString *)title
{
	self = [super init];
    if (self != nil)
    {
		self.wineryCache = cache;
		self.wineryId = wineryid;
		self.wineryType = type;
		self.wineryRefid = refid;
		self.wineryTitle = title;
	}
	return self;
}

@end
