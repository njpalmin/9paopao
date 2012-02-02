//
//  StringHelper.m
//  iosbrowser
//
//  Created by 章金泉 on 11-5-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper

static NSString *REGEX_TRIM_FRONT = @"^\\s+";
static NSString *REGEX_TRIM_TAIL = @"\\s+$";

+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formate setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
    NSString *dateStr = [formate stringFromDate:date];
    [formate release];
    return dateStr;
}

+ (NSDate *)dateFromString:(NSString *)dateStr {
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formate setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
    NSDate *date = [formate dateFromString:dateStr];
    [formate release];
    return date;
}

+ (NSString *)stringByTrimFront:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    NSRange range = [str rangeOfRegex:REGEX_TRIM_FRONT];
    if (range.location != NSNotFound) {
        return [str substringFromIndex:range.length];
    }
    return [NSString stringWithString:str];
}

+ (NSString *)stringByTrimTail:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    NSRange range = [str rangeOfRegex:REGEX_TRIM_TAIL];
    if (range.location != NSNotFound) {
        return [str substringToIndex:range.location];
    }
    return [NSString stringWithString:str];
}

+ (NSString *)stringByTrimEnds:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    NSRange range;
    NSRange subRange = NSMakeRange(0, [str length]);
    range = [str rangeOfRegex:REGEX_TRIM_FRONT];
    if (range.location != NSNotFound) {
        subRange.location = range.length;
        subRange.length -= range.length;
    }
    range = [str rangeOfRegex:REGEX_TRIM_TAIL inRange:subRange];
    if (range.location != NSNotFound) {
        subRange.length -= range.length;
    }
    return [str substringWithRange:subRange];
}

@end
