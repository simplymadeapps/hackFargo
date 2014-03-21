//
//  HackFargoAPIController.m
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "HackFargoAPIController.h"
#import "AFNetworking.h"

static NSString *apiEndpoint = @"http://api.hackfargo.co/";

@implementation HackFargoAPIController

-(id)initWithDelegate:(id<APIControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

+(NSOperationQueue *)sharedOperationQueue {
    static NSOperationQueue *_sharedOperationQueue = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedOperationQueue = [[NSOperationQueue alloc] init];
    });
    return _sharedOperationQueue;
}

- (NSMutableURLRequest *)defaultRequestWithUrlPart:(NSString *)uriPart {
    NSString *apiURIString = [NSString stringWithFormat:@"%@%@",apiEndpoint,[uriPart stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *apiURL = [NSURL URLWithString:apiURIString];
    NSMutableURLRequest *apiRequest = [[NSMutableURLRequest alloc] initWithURL:apiURL];
    
    return apiRequest;
}


#pragma mark Request Managment Code
- (void)requestWithRequest:(NSURLRequest *)httpRequest withParameters:(NSDictionary *)parameters withCallIdentifier:(id)callIdentifier
{
    
    NSError *afserialError;
    
    NSURLRequest *newRequest = [[AFJSONRequestSerializer serializer] requestBySerializingRequest:httpRequest withParameters:parameters error:&afserialError];
    
    if (afserialError) {
        NSMutableDictionary *failDictionary = [[NSMutableDictionary alloc] init];
        [failDictionary setObject:afserialError forKey:@"error"];
        return;
    }
    
    NSOperationQueue *queue = [HackFargoAPIController sharedOperationQueue];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:newRequest];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate requestSuccess:responseObject withCallIdentifier:callIdentifier];
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
                if ([self.delegate respondsToSelector:@selector(requestFailed:withCallIdentifier:)]) {
                    [self.delegate requestFailed:@{@"errorCode":errorCode,@"errorMessage":errorMessage} withCallIdentifier:callIdentifier];
                }
            }
        } else {
            if (operation.isCancelled) {
                NSLog(@"Operation Canceled!");
            } else {
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(requestFailed:withCallIdentifier:)]) {
                        [self.delegate requestFailed:@{@"errorMessage":errorMessage} withCallIdentifier:callIdentifier];
                    }
                }
            }
        }
    }];
    
    [queue addOperation:op];
}

@end
