//
//  DetailViewController.m
//  HackFargo
//
//  Created by Bill Burgess on 3/21/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    NSMutableString *detailText = [[NSMutableString alloc] init];
    NSArray *keys = self.detailItem.allKeys;
    for (NSString *key in keys) {
        [detailText appendString:[NSString stringWithFormat:@"%@: %@\n", key, self.detailItem[key]]];
    }
    detailTextView.text = detailText;
    NSLog(@"detailText: %@", detailText);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
