//
//  DetailViewController.h
//  HackFargo
//
//  Created by Bill Burgess on 3/21/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
    IBOutlet UITextView *detailTextView;
}

@property (strong, nonatomic) NSDictionary *detailItem;

@end
