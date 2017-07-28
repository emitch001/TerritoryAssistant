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
    /*[PFUser logInWithUsernameInBackground:nameInfo password:pass block:^(PFUser * _Nullable user, NSError * _Nullable error) {
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
    }];*/
    
    if ( [nameInfo isEqualToString:@"test"] && [ pass isEqualToString:@"test"]) {
        [self performSegueWithIdentifier:@"Manager" sender:self];
    } else if ( [nameInfo isEqualToString:@"user"] && [ pass isEqualToString:@"user"]) {
        [self performSegueWithIdentifier:@"User" sender:self];
    }
    
}

- (IBAction)unwindToLoginViewController:(UIStoryboardSegue *)segue {
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}





@end
