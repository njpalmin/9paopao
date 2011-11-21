//
//  WineryInfo.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryInfo.h"
#import "RegionInfo.h"

@interface WineryInfo : NSObject {
	
	NSInteger	wineryCache;
	NSString	*wineryId;
	NSString	*wineryType;
	NSString	*wineryRefid;
	NSString	*wineryTitle;
	CountryInfo	*wineryCountry;
	RegionInfo	*wineryRegion;
}

@property(nonatomic, assign)NSInteger	wineryCache;
@property(nonatomic, retain)NSString	*wineryId;
@property(nonatomic, retain)NSString	*wineryType;
@property(nonatomic, retain)NSString	*wineryRefid;
@property(nonatomic, retain)NSString	*wineryTitle;
@property(nonatomic, retain)CountryInfo	*wineryCountry;
@property(nonatomic, retain)RegionInfo	*wineryRegion;
@end
