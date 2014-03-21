//
//  CallsController.m
//  HackFargo
//
//  Created by Randall Fish on 3/20/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "CallsController.h"

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

#pragma mark - API Controller Delegate Methods
-(void)requestSuccess:(id)results withCallIdentifier:(id)callIdentifier {
    NSLog(@"results: %@",results);
    
    if ([callIdentifier isEqualToString:@"AllCalls"]) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(allCallsResults:)]) {
                [self.delegate allCallsResults:results];
            }
        }
    }
}

-(void)requestFailed:(NSDictionary *)results withCallIdentifier:(id)callIdentifier {
    NSLog(@"%@",results);
}
@end
