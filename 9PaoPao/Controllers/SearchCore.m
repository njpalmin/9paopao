//
//  SearchCore.m
//  9PaoPao
//
//  Created by huang jiejie on 11-11-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchCore.h"

#define ERROR_0204			  @"對不起！没有搜尋到相關的資訊。"
#define ERROR_0400			  @"请求参数错误。"
#define ERROR_0401			  @"身份验证错误！电话号码错误。"
#define ERROR_0403			  @"身份验证错误！您的手机未开通此项服务。"
#define ERROR_NET			  @"網絡連接錯誤"
#define	ERROR_TIMEOUT		  @"系統繁忙中,請稍後再試"

@implementation SearchCore

@synthesize delegate = mDelegate;
@synthesize responseData;

- (void)dealloc
{
	[self cancel];
	mDelegate = nil;
	
    [super dealloc];
}

-(id)init
{
	self = [super init];
    if (self != nil)
    {
		mNeedTimeOutWarningTimer = YES;
		binternetWarningShowed = NO;
		bAlartisShowed = NO;
		btimeoutWarningShowed = NO;
		mTimeoutInterval = 30;
	}
	return self;
}

#pragma mark -
#pragma mark Public

- (void)cancel
{
	[self clear];
}

- (BOOL)sendRequestWithServerURL:(NSString *)serverURL SearchString:(NSString *)searchString 
{
	BOOL			iProessSucess = NO;
	NSURLRequest	*request = nil;
    NSString		*req = nil;
	
	[self clear];
	
	if (nil != searchString) {
		req = [NSString stringWithFormat:@"%@%@",serverURL,searchString];
	}else {
		req = [NSString stringWithFormat:@"%@",serverURL];
	}
	req = [req stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	do{
		break_if(nil == req);
		
		NSURL *url = [NSURL URLWithString :req ];
		if(mNeedTimeOutWarningTimer == NO)
		{
			request = [NSURLRequest requestWithURL:url];
		}
		else
		{
			request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:mTimeoutInterval];
		}
		mRequest = [request retain];
		mUrlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		break_if(mUrlConnection == nil);
		
		iProessSucess = YES;
	}while(0);
    
	return iProessSucess;
}

#pragma mark -
#pragma mark NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    do {
        break_if(connection != mUrlConnection);
        
        [mResponse release];
        mResponse = [response retain];        
    } while (0);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	do {
        break_if(connection != mUrlConnection);
        
        if (responseData == nil)
        {
            responseData = [[NSMutableData alloc] initWithCapacity:0];
            break_if(responseData == nil);
        }
        
        [responseData appendData:data];
        
    } while (0);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	do{
		break_if(connection != mUrlConnection);

		if(error.code == -1004 && binternetWarningShowed==NO) //-1004 is error for internet connecting
		{
			UIAlertView *alert = nil;
			NSString *title = NSLocalizedString(@"Alert", nil);
			NSString *message = NSLocalizedString(@"Http Net Error", nil);  
			
			alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
			[alert show];
			[alert release];                        
			binternetWarningShowed = YES;
			bAlartisShowed = YES;
			[mDelegate searchCore:self didFailWithError:error];
		}
		else if(error.code == -1001 && btimeoutWarningShowed==NO)
		{
			UIAlertView *alert = nil;
			NSString *title = NSLocalizedString(@"Alert", nil);
			NSString *message = NSLocalizedString(@"Http Other Error", nil);
			
			if(mNeedTimeOutWarningTimer != NO)
			{
				alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
				[alert show];
				[alert release];                        
				btimeoutWarningShowed = YES;
				bAlartisShowed = YES;
				
				[mDelegate searchCore:self didFailWithError:error];
			}
			else {
				[mDelegate searchCore:self didFailWithError:error];
			}
	    }
		else
		{
			[mDelegate searchCore:self didFailWithError:error];
		}
				
	}while(0);
	
	[pool release];
	pool = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSAutoreleasePool *pool = nil;
    NSHTTPURLResponse *response = nil;
    
    pool = [[NSAutoreleasePool alloc] init];
	
	do {
		break_if(![mResponse isKindOfClass:[NSHTTPURLResponse class]]);
        response = (NSHTTPURLResponse*)mResponse;
        
        if ([response statusCode] != 200)
        {
			UIAlertView *alert = nil;
			NSString *title = NSLocalizedString(@"Alert", nil);
			NSString *message = NSLocalizedString(@"Http Other Error", nil);
			
			alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
			[alert show];
			[alert release];
			bAlartisShowed = YES;
			[mDelegate searchCore:self didFailWithError:nil];
            break;
        }
		
		if (mReceiceString != nil) {
			[mReceiceString release];
		}
		mReceiceString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
		
		if(([mReceiceString length] == 4) && (![mReceiceString isEqualToString:@"0200"]))
		{
			[mDelegate searchCore:self didFailWithError:nil];
		}
		else{
			[mDelegate searchCoreDidFinish:self];
		}
		
		binternetWarningShowed = NO;
		
	}while(0);
	
	[pool release];
	pool = nil;
}

#pragma mark -
#pragma mark Private

- (NSString *)ChineseCharactor2UTF8String:(NSString *)aString
{
	if(nil == aString)return nil;
	NSData   *aData = [aString dataUsingEncoding:NSUTF8StringEncoding];
	int byteCnts = [aData length];
	unsigned char * p = (unsigned char *)[aData bytes];
	NSString * pStr = @"";
	for(int i=0; i<byteCnts; i++)
	{
		pStr = [pStr stringByAppendingFormat:@"%%%X",(*p)];
		p++;
	}
	return pStr;
}

- (NSString*)analyseErrorCode:(NSString*)errorMessage
{
	NSString *tString;
	tString = @"查询失败";
	do
	{
		if([errorMessage isEqualToString:@"0204"])
		{
			tString = ERROR_0204;
			break;
		}
		
		if([errorMessage isEqualToString:@"0400"])
		{
			tString = ERROR_0400;
			break;
		}
		
		if([errorMessage isEqualToString:@"0401"])
		{
			tString = ERROR_0401;
			break;
		}
		
		if([errorMessage isEqualToString:@"0403"])
		{
			tString = ERROR_0403;
			break;
		}
		
	}while(0);
	
	return tString;
}

- (void)clear
{
	if(nil != mRequest){
		[mRequest release];
		mRequest = nil;
	}
	
	if(nil != mUrlConnection){
		[mUrlConnection cancel];
		[mUrlConnection release];
		mUrlConnection = nil;
	}
	
	if(nil != mResponse){
		[mResponse release];
		mResponse = nil;
	}
	
	if(nil != responseData){
		[responseData release];
		responseData = nil;
	}
	
	if(nil != mReceiceString){
		[mReceiceString release];
		mReceiceString = nil;
	}	
}

@end
