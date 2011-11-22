//
//  CountryInfo.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CountryInfo : NSObject {

	NSInteger	countryCache;
	NSString	*countryId;
	NSString	*countryType;
	NSString	*countryRefid;
	NSString	*countryTitle;
}
@property(nonatomic, assign)NSInteger	countryCache;
@property(nonatomic, retain)NSString	*countryId;
@property(nonatomic, retain)NSString	*countryType;
@property(nonatomic, retain)NSString	*countryRefid;
@property(nonatomic, retain)NSString	*countryTitle;

-(id)initWithCache:(NSInteger)cache countryId:(NSString *)countryid type:(NSString *)type 
			 refid:(NSString *)refid title:(NSString *)title;

@end
