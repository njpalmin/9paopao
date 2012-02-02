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

#pragma mark -
#pragma mark Public
- (NSDictionary *)postRegisterAndLoginInfoWithJsonString:(NSString *)jsonStr andUrl:(NSURL *)url;//added by yixl 20120201
- (BOOL)sendRequestWithServerURL:(NSString *)serverURL SearchString:(NSString *)searchString;
- (void)cancel;

#pragma mark -
#pragma mark Private

- (NSString *)ChineseCharactor2UTF8String:(NSString *)aString;
- (NSString*)analyseErrorCode:(NSString*)errorMessage;
- (void)clear;

@end

@protocol SearchCoreDelegate

- (void)searchCoreDidFinish:(SearchCore *)searchCore;
- (void)searchCore:(SearchCore *)searchCore didFailWithError:(NSError*)error;

@end

