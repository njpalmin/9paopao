//
//  SearchManager.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchManager.h"

static	SearchManager	*sDefaultManager = nil;

@implementation SearchManager

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
            
			/*
            mWineItems = [[NSMutableArray alloc] initWithCapacity:0];
            break_if(mFavoriteItems == nil);
                        
            mFriendsItems = [[NSMutableArray alloc] initWithCapacity:0];
            break_if(mLocationItems == nil);
             */           
            
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
    int32_t retval;
    
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
	
}
	
- (void)searchCore:(SearchCore *)searchCore didFailWithError:(NSError*)error
{
	
}

@end
