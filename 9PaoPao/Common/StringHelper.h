//
//  StringHelper.h
//  iosbrowser
//
//  Created by 章金泉 on 11-5-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegexKitLite.h"

@interface StringHelper : NSObject {
    
}

/*!
 @method     stringFromDate:
 @abstract   返回日期的yyyy-MM-dd HH:mm:ss字符串表示
 @discussion 
 @param      date:日期
 @result     返回字符串表示形式
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/*!
 @method     dateFromString:
 @abstract   返回字符串日期表示yyyy-MM-dd HH:mm:ss的NSDate对象
 @discussion 
 @param      dateStr:日期字符串
 @result     返回对应的NSDate对象
 */
+ (NSDate *)dateFromString:(NSString *)dateStr;

/*!
 @method     stringByTrimFront:
 @abstract   返回过滤掉字符串前面的空字符后的子串
 @discussion 空字符包括空格、制表符、换行符
 @param      str:原字符串
 @result     返回过滤后的子串
 */
+ (NSString *)stringByTrimFront:(NSString *)str;

/*!
 @method     stringByTrimTail:
 @abstract   返回过滤掉字符串后面的空字符后的子串
 @discussion 空字符包括空格、制表符、换行符
 @param      str:原字符串
 @result     返回过滤后的子串
 */
+ (NSString *)stringByTrimTail:(NSString *)str;

/*!
 @method     stringByTrimEnds:
 @abstract   返回过滤掉字符串前面、后面的空字符后的子串
 @discussion 空字符包括空格、制表符、换行符
 @param      str:原字符串
 @result     返回过滤后的子串
 */
+ (NSString *)stringByTrimEnds:(NSString *)str;

@end
