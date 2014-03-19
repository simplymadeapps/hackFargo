//
//  HackFargoAPIController.h
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HackFargoAPIParty
} HackFargoAPIName;

@protocol HackFargoAPIControllerDelegate <NSObject>

@required
- (void)requestSuccess:(id)results forAPI:(HackFargoAPIName)apiName;
- (void)requestFailed:(NSError *)error forAPI:(HackFargoAPIName)apiName;

@end

@interface HackFargoAPIController : NSObject


@property (weak, nonatomic) id<HackFargoAPIControllerDelegate>delegate;

- (id)initWithDelegate:(id<HackFargoAPIControllerDelegate>)delegate;
- (void)hackFargoRequestWithAPI:(HackFargoAPIName)apiName withData:(NSDictionary *)data;
@end
