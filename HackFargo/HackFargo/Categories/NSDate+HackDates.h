//
//  NSDate+HackDates.h
//  HackFargo
//
//  Created by Randall Fish on 3/20/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HackDates)

+ (NSDate *)shortAPIDateFromString:(NSString *)dateString;
+ (NSString *)shortAPIDateStringFromDate:(NSDate *)date;

@end
