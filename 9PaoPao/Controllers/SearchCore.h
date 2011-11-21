//
//  SearchCore.h
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchCoreDelegate;

@interface SearchCore : NSObject {

	id<SearchCoreDelegate>		mDelegate;
	NSURLConnection				*mUrlConnection;
	NSURLResponse               *mResponse;
	NSMutableData				*responseData;
    NSMutableString				*mReceiceString;
	BOOL						 binternetWarningShowed;
	BOOL						 bAlartisShowed;
	BOOL						 btimeoutWarningShowed;
	NSUInteger                   mTimeoutInterval;
	NSURLRequest				*mRequest;
	BOOL						mNeedTimeOutWarningTimer;
	
}

@property(nonatomic, assign)id<SearchCoreDelegate>  delegate;
@property(nonatomic, retain)NSMutableData           *responseData;

@end

@protocol SearchCoreDelegate

- (void)searchCoreDidFinish:(SearchCore *)searchCore;
- (void)searchCore:(SearchCore *)searchCore didFailWithError:(NSError*)error;

@end

