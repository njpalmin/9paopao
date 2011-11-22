//
//  RegionInfo.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CountryInfo.h"

@interface RegionInfo : NSObject {

	NSInteger	regionCache;
	NSString	*regionId;
	NSString	*regionType;
	NSString	*regionRefid;
	NSString	*regionTitle;
	CountryInfo	*regionCountry;
}
@property(nonatomic, assign)NSInteger	regionCache;
@property(nonatomic, retain)NSString	*regionId;
@property(nonatomic, retain)NSString	*regionType;
@property(nonatomic, retain)NSString	*regionRefid;
@property(nonatomic, retain)NSString	*regionTitle;
@property(nonatomic, retain)CountryInfo	*regionCountry;

-(id)initWithCache:(NSInteger)cache regionId:(NSString *)regionid type:(NSString *)type 
			 refid:(NSString *)refid title:(NSString *)title;

@end
