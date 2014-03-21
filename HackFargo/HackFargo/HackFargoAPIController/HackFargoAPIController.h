//
//  HackFargoAPIController.h
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIControllerDelegate <NSObject>

@required
- (void)requestSuccess:(id)results withCallIdentifier:(id)callIdentifier;
- (void)requestFailed:(NSDictionary *)results withCallIdentifier:(id)callIdentifier;

@end

@interface HackFargoAPIController : NSObject

@property (nonatomic, strong) id<APIControllerDelegate> delegate;

- (id)initWithDelegate:(id<APIControllerDelegate>)delegate;
- (void)requestWithRequest:(NSURLRequest *)httpRequest withParameters:(NSDictionary *)parameters withCallIdentifier:(id)callIdentifier;
- (NSMutableURLRequest *)defaultRequestWithUrlPart:(NSString *)uriPart;

@end