//
//  HackFargoAnnotation.m
//  HackFargo
//
//  Created by Bill Burgess on 3/21/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "HackFargoAnnotation.h"

@implementation HackFargoAnnotation

- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate {
	self = [super init];
    if (self) {
        self.title = title;
        self.coordinate = coordinate;
    }
	return self;
}

@end
