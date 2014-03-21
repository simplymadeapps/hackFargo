//
//  CallsController.m
//  HackFargo
//
//  Created by Randall Fish on 3/20/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "CallsController.h"
#import "NSDate+HackDates.h"

@implementation CallsController

- (id)initWithDelegate:(id<CallsControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)allCalls {
    HackFargoAPIController *apiController = [[HackFargoAPIController alloc] initWithDelegate:self];
    
    NSMutableURLRequest *callsRequest = [apiController defaultRequestWithUrlPart:@"calls"];
    callsRequest.HTTPMethod = @"GET";
    [apiController requestWithRequest:callsRequest withParameters:nil withCallIdentifier:@"AllCalls"];
}

- (void)callsWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    NSString *endDateString;
    NSString *startDateString = [NSDate shortAPIDateStringFromDate:startDate];
    
    if (!endDate) {
        endDateString = [NSDate shortAPIDateStringFromDate:[NSDate date]];
    } else {
        endDateString = [NSDate shortAPIDateStringFromDate:endDate];
    }
    
    //http://api.hackfargo.co/calls?start=6-20-2013&end=6-21-2013
    
    NSDictionary *params = @{@"start": startDateString, @"end": endDateString};
    HackFargoAPIController *apiController = [[HackFargoAPIController alloc] initWithDelegate:self];
    
    NSMutableURLRequest *callsRequest = [apiController defaultRequestWithUrlPart:@"calls"];
    callsRequest.HTTPMethod = @"GET";
    [apiController requestWithRequest:callsRequest withParameters:params withCallIdentifier:@"CallsByDateRange"];
}

- (void)allParties {
    HackFargoAPIController *apiController = [[HackFargoAPIController alloc] initWithDelegate:self];
    
    NSMutableURLRequest *partyRequest = [apiController defaultRequestWithUrlPart:@"calls/type/Party"];
    partyRequest.HTTPMethod = @"GET";
    [apiController requestWithRequest:partyRequest withParameters:nil withCallIdentifier:@"AllParties"];
}

- (void)partiesWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    NSString *endDateString;
    NSString *startDateString = [NSDate shortAPIDateStringFromDate:startDate];
    
    if (!endDate) {
        endDateString = [NSDate shortAPIDateStringFromDate:[NSDate date]];
    } else {
        endDateString = [NSDate shortAPIDateStringFromDate:endDate];
    }
    
    //http://api.hackfargo.co/calls?start=6-20-2013&end=6-21-2013
    
    NSDictionary *params = @{@"start": startDateString, @"end": endDateString};
    HackFargoAPIController *apiController = [[HackFargoAPIController alloc] initWithDelegate:self];
    
    NSMutableURLRequest *callsRequest = [apiController defaultRequestWithUrlPart:@"calls/type/Party"];
    callsRequest.HTTPMethod = @"GET";
    [apiController requestWithRequest:callsRequest withParameters:params withCallIdentifier:@"PartiesByDateRange"];
}


#pragma mark - API Controller Delegate Methods
-(void)requestSuccess:(id)results withCallIdentifier:(id)callIdentifier {
    NSLog(@"results: %@",results);
    
    if ([callIdentifier isEqualToString:@"AllCalls"]) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(allCallsResults:)]) {
                [self.delegate allCallsResults:results];
            }
        }
    } else if ([callIdentifier isEqualToString:@"CallsByDateRange"]) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(callsByDateRangeResults:)]) {
                [self.delegate callsByDateRangeResults:results];
            }
        }
    } else if ([callIdentifier isEqualToString:@"AllParties"]) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(allPartiesResults:)]) {
                [self.delegate allPartiesResults:results];
            }
        }
    } else if ([callIdentifier isEqualToString:@"PartiesByDateRange"]) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(partiesByDateRangeResults:)]) {
                [self.delegate partiesByDateRangeResults:results];
            }
        }
    }
}

-(void)requestFailed:(NSDictionary *)results withCallIdentifier:(id)callIdentifier {
    NSLog(@"%@",results);
}
@end
