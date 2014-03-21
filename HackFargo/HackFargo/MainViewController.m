//
//  MainViewController.m
//  HackFargo
//
//  Created by Bill Burgess on 3/19/14.
//  Copyright (c) 2014 Simply Made Apps. All rights reserved.
//

#import "MainViewController.h"
#import "HackFargoAnnotation.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // map view starts hidden
    mapView.hidden = YES;
    
    //[self setAutomaticallyAdjustsScrollViewInsets:YES];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    listTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    CallsController *controller = [[CallsController alloc] initWithDelegate:self];
    [controller allCalls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)controlSwitchChanged:(id)sender {
    if (controlSwitch.selectedSegmentIndex == 0) {
        // show list view
        listTable.hidden = NO;
        mapView.hidden = YES;
    } else {
        // show map view
        mapView.hidden = NO;
        listTable.hidden = YES;
    }
}

#pragma mark - TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"HackCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *item = self.listItems[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item[@"Description"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self performSegueWithIdentifier:@"PushDetailView" sender:self.listItems[indexPath.row]];
    
}

#pragma mark - CallsControllerDelegate Methods

-(void)allCallsResults:(NSArray *)calls {
    NSLog(@"%@",calls);
    self.listItems = calls;
    [self updateMapPins];
    [listTable reloadData];
}

- (void)requestFailed:(NSDictionary *)results {
    NSLog(@"%@",results);
}

#pragma mark - Map Helper Methods
- (void)updateMapPins {
    // Add the annotation to our map view
    NSMutableArray *annotations = [NSMutableArray new];
    for (NSDictionary *dict in self.listItems) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([dict[@"Lat"] doubleValue], [dict[@"Long"] doubleValue]);
        HackFargoAnnotation *annotation = [[HackFargoAnnotation alloc] initWithTitle:dict[@"Description"] andCoordinate:coord];
        [annotations addObject:annotation];
    }
    [mapView showAnnotations:annotations animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"preparing for segue");
    if ([segue.identifier isEqualToString:@"PushDetailView"]) {
        NSDictionary *item = (NSDictionary *)sender;
        DetailViewController *detailView = segue.destinationViewController;
        detailView.detailItem = item;
        detailView.title = item[@"Description"];
    }
}

@end
