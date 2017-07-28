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
    [self.territoryarray addObject: @"Territory 1"];
 
    [self.territoryarray addObject: @"Territory 2"];
 
    [self.territoryarray addObject: @"Territory 3"];

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
    UILabel *label = (UILabel *) [cell viewWithTag:1];
    label.text = territoryNumber;
    
    UILabel *label2 = (UILabel *) [cell viewWithTag:2];
    label2.text = [territory valueForKey:@"User"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *terr = self.territoryarray[indexPath.row];
    self.selectedTerr = terr;
    [self performSegueWithIdentifier:@"territory" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
