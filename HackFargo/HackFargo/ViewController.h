//
//  ViewController.h
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallsController.h"

@interface ViewController : UIViewController <CallsControllerDelegate> {
    IBOutlet UIButton *callAPI;
}

- (IBAction)callAPIPressed:(id)sender;

@end
