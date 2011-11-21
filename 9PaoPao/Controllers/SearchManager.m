//
//  SearchManager.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchManager.h"

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
	
- (void)analysisWineResultList:(NSDictionary *)dictionary
{
	NSArray	*wineList = (NSArray *)dictionary;
	
	for (int i = 0; i < [wineList count]; i++) {
		
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

@end
