//
//  ViewController.m
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callAPIPressed:(id)sender {
    HackFargoAPIController *controller = [[HackFargoAPIController alloc] initWithDelegate:self];
    [controller hackFargoRequestWithAPI:HackFargoAPIParty withData:nil];
}

#pragma mark -
@end
