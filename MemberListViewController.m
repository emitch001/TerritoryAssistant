//
//  MemberListViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/28/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "MemberListViewController.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"

@interface MemberListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *membertableview;
@property NSMutableArray *membersarray;
@property NSString *selectedName;
@property NSString *selectedEmail;
@property NSNumber *selectedTerritory;

@end


@implementation MemberListViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.membersarray = [[NSMutableArray alloc] init];
    self.membertableview.delegate = self;
    self.membertableview.dataSource = self;
    self.title = @"Members";
}

- (void) viewWillAppear:(BOOL)animated {
    PFQuery *query = [PFQuery queryWithClassName:@"Members"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.membersarray = [objects mutableCopy];
            [self.membertableview reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.membersarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"memberCell"];
    }
    
    PFObject *member = self.membersarray[indexPath.row];
    
    NSString *membername = [member valueForKey:@"Name"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = membername;
    if ([[member valueForKey:@"Territory"] intValue] != -1) {
        NSString *terrNumber = [[member valueForKey:@"Territory"] stringValue];
        UILabel *terrLabel = (UILabel *)[cell viewWithTag:2];
        terrLabel.text = terrNumber;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *member = self.membersarray[indexPath.row];
    self.selectedName = [member valueForKey:@"Name"];
    self.selectedEmail = [member valueForKey:@"email"];
    self.selectedTerritory = [member valueForKey:@"Territory"];
    [self performSegueWithIdentifier:@"memberProfile" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"memberProfile"]) {
        ProfileViewController *contr = segue.destinationViewController;
        contr.memberName = self.selectedName;
        contr.email = self.selectedEmail;
        contr.terrNumber = self.selectedTerritory;
    }
}


@end
