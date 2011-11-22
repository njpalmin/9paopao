//
//  SearchManager.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchCore.h"
#import "JSON.h"

@class CountryInfo;
@class WineryInfo;
@class RegionInfo;

enum SearchType {
    SearchType_None         = 0,
    SearchType_WineList     = 1,
    SearchType_WineryList   = 2,
    SearchType_BeerList     = 3,
    SearchType_BreweryList  = 4
};

@protocol SearchManagerDelegate;

@interface SearchManager : NSObject<SearchCoreDelegate> {

    id<SearchCoreDelegate>  mDelegate;
	SearchCore              *mSearchCore;
    enum SearchType         mSearchType;
    NSInteger               mRequestPage;
    NSDictionary            *mSearchResultDic;
	
	NSArray					*mWineListResults;
}
@property(nonatomic, assign)id<SearchCoreDelegate>  delegate;
@property(nonatomic, assign)enum SearchType         searchType;
@property(nonatomic, retain)NSDictionary            *searchResultDic;
@property(nonatomic, retain)NSArray					*wineListResults;

+ (SearchManager *)defaultSearchManager;

#pragma mark -
#pragma mark Private

- (void)analysisWineResultList:(NSDictionary *)dictionary;
- (CountryInfo *)analysisCountryResult:(NSDictionary *)dictionary;
- (WineryInfo *)analysisWineryResult:(NSDictionary *)dictionary;
- (RegionInfo *)analysisRegionResult:(NSDictionary *)dictionary;

@end

@protocol SearchManagerDelegate <NSObject>

- (void)searchManagerDidFinish:(SearchManager *)manager;
- (void)searchManager:(SearchManager *)manager didFailWithError:(NSError*)error;
@end