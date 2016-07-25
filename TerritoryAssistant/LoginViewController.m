//
//  LoginViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/13/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "TerritoryViewController.h"

@interface LoginViewController()

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property NSNumber *selectedTerr;
@property PFObject *terr;

@end

@implementation LoginViewController

- (void) viewDidLoad {
    self.password.secureTextEntry = YES;
}

- (IBAction)logIn:(id)sender {
    NSString *nameInfo = self.username.text;
    NSString * pass = self.password.text;
    [PFUser logInWithUsernameInBackground:nameInfo password:pass block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
            if ([[user valueForKey:@"Type"] isEqualToString:@"Manager"]) {
                [self performSegueWithIdentifier:@"Manager" sender:self];
            } else {
                PFQuery *query = [PFQuery queryWithClassName:@"Members"];
                [query whereKey:@"username" equalTo:nameInfo];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        PFObject *user = [objects objectAtIndex:0];
                        if ([[user valueForKey:@"Territory"] intValue] != -1) {
                            self.selectedTerr = [user valueForKey:@"Territory"];
                            PFQuery *query2 = [PFQuery queryWithClassName:@"Territory"];
                            self.terr = [[query2 findObjects] objectAtIndex:0];
                            [self performSegueWithIdentifier:@"User" sender:self];
                        } else {
                            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"User does not have a territory. Please alert a manager to receive a territory!" preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                            [controller addAction:defaultAction];
                            [self presentViewController:controller animated:YES completion:nil];
                        }
                    }
                }];
            }
        } else {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [controller addAction:defaultAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];
    
}

- (IBAction)unwindToLoginViewController:(UIStoryboardSegue *)segue {
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"User"]) {
        TerritoryViewController *tvc2 = segue.destinationViewController;
        PFObject *obj = self.terr;
        tvc2.pt0 = [obj valueForKey:@"Lat0"];
        tvc2.pt1 = [obj valueForKey:@"Lat1"];
        tvc2.pt2 = [obj valueForKey:@"Lat2"];
        tvc2.pt3 = [obj valueForKey:@"Lat3"];
        tvc2.pt00 = [obj valueForKey:@"Long0"];
        tvc2.pt01 = [obj valueForKey:@"Long1"];
        tvc2.pt02 = [obj valueForKey:@"Long2"];
        tvc2.pt03 = [obj valueForKey:@"Long3"];
        tvc2.notes = [obj valueForKey:@"Notes"];
        tvc2.num = [obj valueForKey:@"Number"];
    }
}





@end
