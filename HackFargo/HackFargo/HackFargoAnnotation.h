//
//  HackFargoAnnotation.h
//  HackFargo
//
//  Created by Bill Burgess on 3/21/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HackFargoAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
