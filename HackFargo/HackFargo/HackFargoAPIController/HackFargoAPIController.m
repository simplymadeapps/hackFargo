//
//  HackFargoAPIController.m
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "HackFargoAPIController.h"
#import "AFNetworking.h"

static NSString *hackFargoAPIEndpoint = @"http://api.hackfargo.co";
static NSString *hackFargoAPICalls = @"/calls";
static NSString *hackFargoAPIType = @"/type";

@implementation HackFargoAPIController

- (id)initWithDelegate:(id<HackFargoAPIControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)hackFargoRequestWithAPI:(HackFargoAPIName)apiName withData:(NSDictionary *)data {
    switch (apiName) {
        case HackFargoAPIParty: {
            NSMutableURLRequest *request = [self hackFargoRequestWithEndpoint:hackFargoAPICalls];
            break;
        }
        default:
            break;
    }
}

- (NSMutableURLRequest *)hackFargoRequestWithEndpoint:(NSString *)endpoint {
    
    NSString *apiURIString = [NSString stringWithFormat:@"%@%@",hackFargoAPIEndpoint, endpoint];
    NSURL *apiURL = [NSURL URLWithString:apiURIString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:apiURL];
    
    return request;
}

- (void)hackFargoRequestWithRequest:(NSURLRequest *)httpRequest forApi:(HackFargoAPIName)apiName withParameters:(NSDictionary *)parameters
{
    NSError *afserialError;
    
    NSURLRequest *newRequest = [[AFJSONRequestSerializer serializer] requestBySerializingRequest:httpRequest withParameters:parameters error:&afserialError];
    
    if (afserialError) {
        NSMutableDictionary *failDictionary = [[NSMutableDictionary alloc] init];
        [failDictionary setObject:afserialError forKey:@"error"];
        return;
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:newRequest];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.delegate) {
            id resultObjects = [self processReturnDataFromAPI:apiName withDataObject:responseObject];
            
            if ([self.delegate respondsToSelector:@selector(requestSuccess:forAPI:)]) {
                [self.delegate requestSuccess:resultObjects forAPI:apiName];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        id errorCode;
        NSString *errorMessage;
        
        if (!error) {
            errorMessage = NSLocalizedString(@"API Manager Generic Error",@"API Manager Generic Error");
        } else {
            errorMessage = error.localizedDescription;
        }
        
        if (operation.request) {
            NSLog(@"\nURL: %@\n-- Request Headers --\n%@",operation.request.URL,[operation.request allHTTPHeaderFields]);
            if (operation.request.HTTPBody) {
                NSString *bodyData = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"\n-- Request Params --\n%@",bodyData);
            }
        }
        
        if (operation.response) {
            NSLog(@"\n-- Response Headers --\n%@",[operation.response allHeaderFields]);
            NSLog(@"\n-- Response Body --\n%@",operation.responseString);
            
            if (operation.responseObject) {
                errorCode = [operation.responseObject valueForKeyPath:@"D.Code"];
            }
        }
        
        if (operation.response) {
            errorCode = [NSNumber numberWithInteger:operation.response.statusCode];
            
            if (operation.responseObject) {
                NSString *message = [operation.responseObject valueForKey:@"error_description"];
                NSString *responseBodyError = [operation.responseObject valueForKey:@"error"];
                
                if (message) {
                    errorMessage = message;
                }
                if (responseBodyError) {
                    errorCode = responseBodyError;
                }
            }
            
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(requestFailed:forAPI:)]) {
                    //[self.delegate requestFailed:@{@"errorCode":errorCode,@"errorMessage":errorMessage}];
                }
            }
        } else {
            if (operation.isCancelled) {
                NSLog(@"Operation Canceled!");
            } else {
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(requestFailed:forAPI:)]) {
                        //[self.delegate requestFailed:@{@"errorMessage":errorMessage}];
                    }
                }
            }
        }
    }];
    
    [queue addOperation:op];
}

- (id)processReturnDataFromAPI:(HackFargoAPIName)apiName withDataObject:(id)dataObject {
    NSDictionary *fullResponse;
    
    if ([dataObject isKindOfClass:[NSDictionary class]]) {
        fullResponse = (NSDictionary *)dataObject;
    }
    
    return fullResponse;
}


@end
