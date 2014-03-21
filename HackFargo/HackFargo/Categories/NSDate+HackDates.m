//
//  NSDate+HackDates.m
//  HackFargo
//
//  Created by Randall Fish on 3/20/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "NSDate+HackDates.h"
#import <time.h>
#import <xlocale.h>

// %Y-%m-%dT%T%z
// %Y-%m-%dT%H:%M:%S%z - https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man3/strftime.3.html#//apple_ref/doc/man/3/strftime
//static const char *serverFormat = "%Y-%m-%dT%T%z";
static const char *shortAPIFormat = "%m-%d-%Y";

// Aug 20 1990 - localized
//static const char *shortDisplayFormat = "%b %d %Y";

@implementation NSDate (HackDates)

+ (NSDate *)shortAPIDateFromString:(NSString *)dateString {
    
    const char *str = [dateString UTF8String];
    NSDate *returnDate;
    char *ret;
    
    struct tm timeInfo;
    memset(&timeInfo, 0, sizeof(timeInfo));
    //NULL is en_US_POSIX
    ret = strptime_l(str, shortAPIFormat, &timeInfo, NULL);
    
    if (ret) {
        time_t parsedtime = mktime(&timeInfo);
        returnDate = [NSDate dateWithTimeIntervalSince1970:parsedtime];
        return returnDate;
    } else {
        return nil;
    }
}

+ (NSString *)shortAPIDateStringFromDate:(NSDate *)date {
    
    time_t timeToParse = (time_t)date;
    struct tm timeInfo;
    gmtime_r(&timeToParse, &timeInfo);
    char buffer[32];
    //NULL is en_US_POSIX
    size_t ret = strftime_l(buffer, sizeof(buffer), shortAPIFormat, &timeInfo, NULL);
    if (ret) {
        return @(buffer);
    } else {
        return nil;
    }
}



@end
