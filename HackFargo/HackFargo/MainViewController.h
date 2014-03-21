//
//  MainViewController.h
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CallsController.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CallsControllerDelegate> {
    IBOutlet UIButton *callAPI;
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *listTable;
    IBOutlet UISegmentedControl *controlSwitch;
}

@property (strong, nonatomic) NSArray *listItems;

- (IBAction)controlSwitchChanged:(id)sender;

@end
