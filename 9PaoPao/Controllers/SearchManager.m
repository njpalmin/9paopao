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

#define SearchHostUrl       @"http://api.9paopao.com/"
#define SearchTypeUrl       @"1/search/result?"
#define SearchWineInfoUrl   @"1/wine/info/"

static	SearchManager	*sDefaultManager = nil;

@implementation SearchManager

@synthesize delegate = mDelegate;
@synthesize searchType = mSearchType;
@synthesize searchResultDic = mSearchResultDic;
@synthesize wineListResults = mWineListResults;
@synthesize wineDetailInfo = mWineDetailInfo;

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
        goto ErrorLabel;
    }
    
    jsonReturnStr = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    if(jsonReturnStr == nil || [jsonReturnStr compare:@""] == NSOrderedSame) {
        
        failed = YES;
        goto ErrorLabel;
    }
    
    NSLog(@"jsonReturnStr = %@", jsonReturnStr);
    
    reDic = [jsonReturnStr JSONValue];
    if ((reDic == nil) || ([reDic count] == 0)) {
        failed = YES;
        goto ErrorLabel;
    }
  
ErrorLabel:
    if (failed) {
        // search result number 0
        UIAlertView *alert = nil;
        NSString *title = NSLocalizedString(@"Alert", nil);
        NSString *message = NSLocalizedString(@"No Result For Search", nil);  
        
        alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        alert = nil;
        
        [mDelegate searchManager:self didFailWithError:nil];
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
            [self analysisRedWineResultList:reDic];
            break;
        case SearchType_WineDetail:
            [self analysisWineDetailInfo:reDic];
            break;
        default:
            break;
    }
    [mDelegate searchManagerDidFinish:self];
    
    if (jsonReturnStr) {
        [jsonReturnStr release];
        jsonReturnStr = nil;
    }
}

- (void)searchCore:(SearchCore *)searchCore didFailWithError:(NSError*)error
{
    [mDelegate searchManager:self didFailWithError:error];
}

#pragma mark -
#pragma mark Public

- (void)cancelSearch
{
    [mSearchCore cancel];
}

//added by yixl to register 20120201
- (void)startRegisterWithUserName:(NSString *)name 
                         andEmail:(NSString *)email 
                   andPhoneNumber:(NSString *)num 
                      andPassword:(NSString *)password 
                     andSessionId:(NSString *)sess
{
    NSString *composeInfo = [NSString stringWithFormat:@"username=%@&email=%@&phone=%@&password=%@",name,email,num,password];
    NSDictionary *dic = [mSearchCore postRegisterAndLoginInfoWithJsonString:composeInfo 
                                                                     andUrl:[NSURL URLWithString:@"http://api.9paopao.com/1/user/register"]];
    [self.delegate finishRegisterWithReturnInfo:dic];
}

- (void)startLoginWithUserName:(NSString *)name 
                   andPassword:(NSString *)password 
                  andSessionId:(NSString *)sess
{
    NSString *composeInfo = [NSString stringWithFormat:@"username=%@&password=%@",name,password];
    NSDictionary *dic = [mSearchCore postRegisterAndLoginInfoWithJsonString:composeInfo 
                                                                     andUrl:[NSURL URLWithString:@"http://api.9paopao.com/1/user/login"]];
    [self.delegate finishLoginWithReturnInfo:dic];
}

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
            [searchStr appendString:SearchTypeUrl];
            [searchStr appendFormat:@"kw=%@&page=%d&type=4", keyword, mRequestPage];
            break;
        default:
            break;
    }
    
    if (searchStr) {
        [mSearchCore sendRequestWithServerURL:SearchHostUrl SearchString:searchStr];
    }
}

- (void)startSearchWineDetailWithId:(NSString *)wineId withType:(NSInteger)type
{
    NSMutableString     *searchStr = nil;
    
    searchStr = [NSMutableString stringWithCapacity:0];
    mSearchType = type;
    
    switch (mSearchType) {
        case SearchType_WineDetail:
            [searchStr appendString:SearchWineInfoUrl];
            [searchStr appendFormat:@"id/%@", wineId];
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
        
        wineryDic = [wineResult valueForKey:PPWineryKey];
        countryDic = [wineResult valueForKey:PPCountryKey];
        regionDic = [wineResult valueForKey:PPRegionKey];
        
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
        [wineInfo release];
        wineInfo = nil;
	}
    
    self.wineListResults = wineInfoLists;
    
    [wineInfoLists release];
    wineInfoLists = nil;
}

- (void)analysisRedWineResultList:(NSDictionary *)dictionary
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
        NSString        *creatDate = nil;
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
        creatDate = [wineResult valueForKey:PPCreatDate];

        wineInfo = [[WineDetailInfo alloc] initWithCache:cache wineId:wineid score:score type:type refid:refid title:title year:year];
        wineInfo.wineCreatDate = creatDate;
        
        wineryDic = [wineResult valueForKey:PPWineryKey];
        countryDic = [wineResult valueForKey:PPCountryKey];
        regionDic = [wineResult valueForKey:PPRegionKey];
        
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
        [wineInfo release];
        wineInfo = nil;
	}
    
    self.wineListResults = wineInfoLists;
    
    [wineInfoLists release];
    wineInfoLists = nil;
}

- (void)analysisWineDetailInfo:(NSDictionary *)dictionary
{   
	NSDictionary    *wineResult = dictionary;
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
	
	wineryDic = [wineResult valueForKey:PPWineryKey];
	countryDic = [wineResult valueForKey:PPCountryKey];
	regionDic = [wineResult valueForKey:PPRegionKey];
	
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
    
    self.wineDetailInfo = wineInfo;
	
	[wineInfo release];
	wineInfo = nil;
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
    return [country autorelease];
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
    
    return [winery autorelease];
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
