//
//  CountryInfo.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CountryInfo.h"


@implementation CountryInfo
@synthesize countryCache, countryId, countryType, countryRefid, countryTitle;

- (void)dealloc
{
	[countryId release];
	countryId = nil;
	
	[countryType release];
	countryType = nil;
	
	[countryRefid release];
	countryRefid = nil;
	
	[countryTitle release];
	countryTitle = nil;
	
    [super dealloc];
}

-(id)initWithCache:(NSInteger)cache countryId:(NSString *)countryid type:(NSString *)type 
			 refid:(NSString *)refid title:(NSString *)title
{
	self = [super init];
    if (self != nil)
    {
		self.countryCache = cache;
		self.countryId = countryid;
		self.countryType = type;
		self.countryRefid = refid;
		self.countryTitle = title;
	}
	return self;
}

@end
