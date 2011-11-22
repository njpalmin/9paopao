//
//  SearchManager.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchManager.h"
#import "WineDetailInfo.h"
#import "PaoPaoConstant.h"

#define SearchHostUrl   @"http://api.9paopao.com/"
#define SearchTypeUrl   @"1/search/result?"

static	SearchManager	*sDefaultManager = nil;

@implementation SearchManager

@synthesize delegate = mDelegate;
@synthesize searchType = mSearchType;
@synthesize searchResultDic = mSearchResultDic;
@synthesize wineListResults = mWineListResults;

+ (SearchManager *)defaultSearchManager
{
	if (sDefaultManager == nil) {
		sDefaultManager = [[SearchManager alloc] init];
	}
	return sDefaultManager;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        BOOL succeed = NO;
        
        do {
            mSearchCore = [[SearchCore alloc] init];
            mSearchCore.delegate = self;
			/*
            mWineItems = [[NSMutableArray alloc] initWithCapacity:0];
            break_if(mFavoriteItems == nil);
                        
            mFriendsItems = [[NSMutableArray alloc] initWithCapacity:0];
            break_if(mLocationItems == nil);
             */           
            
            mSearchType = SearchType_None;
            
            // Completion
            
            if (sDefaultManager == nil)
            {
                sDefaultManager = self;
            }
            
            succeed = YES;
            
        } while (0);
        
        if (!succeed)
        {
            [self release];
            self = nil;
        }
    }
    return self;
}

- (void)dealloc
{    
    if (sDefaultManager == self)
    {
        sDefaultManager = nil;
    }
    
    [mSearchCore cancel];
    [mSearchCore release];
    mSearchCore = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark SearchCoreDelegate

- (void)searchCoreDidFinish:(SearchCore *)searchCore
{
    NSData          *resultData = nil;
    NSString        *jsonReturnStr = nil;
    NSDictionary    *reDic = nil;
    BOOL            failed = NO;
    
    resultData = searchCore.responseData;
    if ((resultData == nil) || ([resultData length] == 0)) {
        
        failed = YES;
    }
    
    jsonReturnStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    if(jsonReturnStr == nil || [jsonReturnStr compare:@""] == NSOrderedSame) {
        [jsonReturnStr release];
        jsonReturnStr = nil;
        
        failed = YES;
    }
    
    NSLog(@"jsonReturnStr = %@", jsonReturnStr);
    
    reDic = [jsonReturnStr JSONValue];
    if (reDic == nil) {
        failed = YES;
    }
    
    if (failed) {
        // search result number 0
        return;
    }
    
    self.searchResultDic = reDic;
    switch (mSearchType) {
        case SearchType_WineList:
			[self analysisWineResultList:reDic];
			
            break;
        case SearchType_WineryList:
            
            break;
        case SearchType_BeerList:
            
            break;
        case SearchType_BreweryList:
            
            break;
        default:
            break;
    }
}

- (void)searchCore:(SearchCore *)searchCore didFailWithError:(NSError*)error
{
	
}

#pragma mark -
#pragma mark Public

- (void)startSearchWithKeyword:(NSString *)keyword withType:(NSInteger)type withPage:(NSInteger)pages
{
    NSMutableString     *searchStr = nil;
    
    searchStr = [NSMutableString stringWithCapacity:0];
    mSearchType = type;
    mRequestPage = pages;
                 
    switch (mSearchType) {
        case SearchType_WineList:
            [searchStr appendString:SearchTypeUrl];
            [searchStr appendFormat:@"kw=%@&page=%d&type=1", keyword, mRequestPage];
            break;
        case SearchType_WineryList:
            
            break;
        case SearchType_BeerList:
            
            break;
        case SearchType_BreweryList:
            
            break;
        default:
            break;
    }
    
    if (searchStr) {
        [mSearchCore sendRequestWithServerURL:SearchHostUrl SearchString:searchStr];
    }
}

#pragma mark -
#pragma mark Private

- (void)analysisWineResultList:(NSDictionary *)dictionary
{
	NSArray         *wineList = (NSArray *)dictionary;
	NSMutableArray  *wineInfoLists = nil;
    
    wineInfoLists = [[NSMutableArray alloc] initWithCapacity:0];
	for (int i = 0; i < [wineList count]; i++) {
        
		NSDictionary    *wineResult = [wineList objectAtIndex:i];
        WineDetailInfo  *wineInfo = nil;
        NSString        *wineid = nil;
        NSString        *type = nil;
        NSString        *refid = nil;
        NSString        *title = nil;
        NSString        *year = nil;
        NSInteger       cache = -1;
        CGFloat         score = 0.0;
        WineryInfo      *winery = nil;
        CountryInfo     *country = nil;
        RegionInfo      *region = nil;
        NSDictionary    *wineryDic = nil;
        NSDictionary    *countryDic = nil;
        NSDictionary    *regionDic = nil;
        
        cache = [[wineResult valueForKey:PPCachedKey] intValue];
        score = [[wineResult valueForKey:PPScoreKey] floatValue];
        wineid = [wineResult valueForKey:PPIdKey];
        type = [wineResult valueForKey:PPTypeKey];
        title = [wineResult valueForKey:PPTitleKey];
        year = [wineResult valueForKey:PPYearKey];
        refid = [wineResult valueForKey:PPRefidKey];
        
        wineInfo = [[WineDetailInfo alloc] initWithCache:cache wineId:wineid score:score type:type refid:refid title:title year:year];
        
        wineryDic = [dictionary valueForKey:PPWineryKey];
        countryDic = [dictionary valueForKey:PPCountryKey];
        regionDic = [dictionary valueForKey:PPRegionKey];
        
        if (wineryDic) {
            winery = [self analysisWineryResult:wineryDic];
            wineInfo.wineWinery = winery;
        }
        
        if (countryDic) {
            country = [self analysisCountryResult:countryDic];
            wineInfo.wineCountry = country;
        }
        
        if (regionDic) {
            region = [self analysisRegionResult:regionDic];
            wineInfo.wineRegion = region;
        }
        
        [wineInfoLists addObject:wineInfo];
	}
    
    self.wineListResults = wineInfoLists;
    
    [wineInfoLists release];
    wineInfoLists = nil;
}

- (CountryInfo *)analysisCountryResult:(NSDictionary *)dictionary
{
    CountryInfo *country = nil;
    
    if (dictionary == nil) {
        return country;
    }
    
    NSString        *countryid = nil;
    NSString        *type = nil;
    NSString        *refid = nil;
    NSString        *title = nil;
    NSInteger       cache = -1;
    
    cache = [[dictionary valueForKey:PPCachedKey] intValue];
    countryid = [dictionary valueForKey:PPIdKey];
    type = [dictionary valueForKey:PPTypeKey];
    title = [dictionary valueForKey:PPTitleKey];
    refid = [dictionary valueForKey:PPRefidKey];
    
    country = [[CountryInfo alloc] initWithCache:cache countryId:countryid type:type refid:refid title:title];
    return [CountryInfo autorelease];
}

- (WineryInfo *)analysisWineryResult:(NSDictionary *)dictionary
{
    WineryInfo  *winery = nil;
    
    if (dictionary == nil) {
        return winery;
    }
    
    NSString        *wineryid = nil;
    NSString        *type = nil;
    NSString        *refid = nil;
    NSString        *title = nil;
    NSInteger       cache = -1;
    NSDictionary    *countryDic = nil;
    CountryInfo     *country = nil;
    NSDictionary    *regionDic = nil;
    RegionInfo      *region = nil;
    
    cache = [[dictionary valueForKey:PPCachedKey] intValue];
    wineryid = [dictionary valueForKey:PPIdKey];
    type = [dictionary valueForKey:PPTypeKey];
    title = [dictionary valueForKey:PPTitleKey];
    refid = [dictionary valueForKey:PPRefidKey];
    countryDic = [dictionary valueForKey:PPCountryKey];
    regionDic = [dictionary valueForKey:PPRegionKey];
    
    winery = [[WineryInfo alloc] initWithCache:cache wineryId:wineryid type:type refid:refid title:title];
    
    if (countryDic) {
        country = [self analysisCountryResult:countryDic];
        winery.wineryCountry = country;
    }
    
    if (regionDic) {
        region = [self analysisRegionResult:regionDic];
        winery.wineryRegion = region;
    }
    
    return [region autorelease];
}

- (RegionInfo *)analysisRegionResult:(NSDictionary *)dictionary
{
    RegionInfo      *region = nil;
    
    if (dictionary == nil) {
        return region;
    }
    
    NSString        *regionid = nil;
    NSString        *type = nil;
    NSString        *refid = nil;
    NSString        *title = nil;
    NSInteger       cache = -1;
    NSDictionary    *countryDic = nil;
    CountryInfo     *country = nil;
    
    cache = [[dictionary valueForKey:PPCachedKey] intValue];
    regionid = [dictionary valueForKey:PPIdKey];
    type = [dictionary valueForKey:PPTypeKey];
    title = [dictionary valueForKey:PPTitleKey];
    refid = [dictionary valueForKey:PPRefidKey];
    countryDic = [dictionary valueForKey:PPCountryKey];
    
    region = [[RegionInfo alloc] initWithCache:cache regionId:regionid type:type refid:refid title:title];
    if (countryDic) {
        country = [self analysisCountryResult:countryDic];
        region.regionCountry = country;
    }
    
    return [region autorelease];
}

@end
