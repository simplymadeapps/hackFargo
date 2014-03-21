//
//  CallsController.h
//  HackFargo
//
//  Created by Randall Fish on 3/20/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackFargoAPIController.h"

@protocol CallsControllerDelegate <NSObject>

@required
- (void)requestFailed:(NSDictionary *)results;

@optional
- (void)allCallsResults:(NSArray *)calls;
- (void)callsByDateRangeResults:(NSArray *)calls;
- (void)allPartiesResults:(NSArray *)parties;
- (void)partiesByDateRangeResults:(NSArray *)parties;

@end

@interface CallsController : NSObject <APIControllerDelegate>

@property (nonatomic, weak) id<CallsControllerDelegate> delegate;

- (id)initWithDelegate:(id<CallsControllerDelegate>)delegate;
- (void)allCalls;
- (void)callsWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate;
- (void)allParties;
- (void)partiesWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate;

@end
