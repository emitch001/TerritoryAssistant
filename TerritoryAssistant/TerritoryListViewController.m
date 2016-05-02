//
//  TerritoryListViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/13/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "TerritoryListViewController.h"
#import <Parse/Parse.h>
#import "TerritoryViewController.h"
#include <MapKit/MapKit.h>

@interface TerritoryListViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *territoryarray;
@property (strong, nonatomic) IBOutlet UITableView *territorytableview;
@property PFObject *selectedTerr;

@end

@implementation TerritoryListViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.territoryarray = [[NSMutableArray alloc] init];
    self.territorytableview.delegate = self;
    self.territorytableview.dataSource = self;
    self.title = @"Territories";
}


- (void) viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Territory"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.territoryarray = [objects mutableCopy];
            [self.territorytableview reloadData];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.territoryarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"terrcell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    PFObject *territory = self.territoryarray[indexPath.row];
    
    NSString *territoryNumber = [territory valueForKey:@"Number"];
    
    NSLog(@"Territory number: %@", territoryNumber);
    UILabel *label = (UILabel *) [cell viewWithTag:1];
    label.text = territoryNumber;
    
    UILabel *label2 = (UILabel *) [cell viewWithTag:2];
    label2.text = [territory valueForKey:@"User"];
    NSLog(@"User name: %@", label2.text);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *terr = self.territoryarray[indexPath.row];
    self.selectedTerr = terr;
    [self performSegueWithIdentifier:@"territory" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.description isEqualToString:@"territory"]) {
        NSLog(@"Prepare Called");
        TerritoryViewController *tvc = segue.destinationViewController;
        tvc.pt0 = [self.selectedTerr valueForKey:@"Lat0"];
        tvc.pt1 = [self.selectedTerr valueForKey:@"Lat1"];
        tvc.pt2 = [self.selectedTerr valueForKey:@"Lat2"];
        tvc.pt3 = [self.selectedTerr valueForKey:@"Lat3"];
        
        tvc.pt00 = [self.selectedTerr valueForKey:@"Long0"];
        tvc.pt01 = [self.selectedTerr valueForKey:@"Long1"];
        tvc.pt02 = [self.selectedTerr valueForKey:@"Long2"];
        tvc.pt03 = [self.selectedTerr valueForKey:@"Long3"];
        
        tvc.notes = [self.selectedTerr valueForKey:@"Notes"];
        tvc.num = [self.selectedTerr valueForKey:@"Number"];
        NSLog(@"Prepare Ended");
    }
}

@end
