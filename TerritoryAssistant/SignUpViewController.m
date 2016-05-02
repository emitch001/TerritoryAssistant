//
//  SignUpViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/13/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController()

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UISwitch *manager;


@end

@implementation SignUpViewController

- (IBAction)signUpButtonPressed:(id)sender {
    NSString *username = self.username.text;
    NSString * email = self.emailAddress.text;
    NSString * pass = self.password.text;
    NSString * name = self.name.text;
    PFUser *myUser = [PFUser user];
    myUser.username = username;
    myUser.password = pass;
    myUser.email = email;
    if (self.manager.isOn) {
        [myUser setValue:@"Manager" forKey:@"Type"];
    } else {
        [myUser setValue:@"User" forKey:@"Type"];
    }
    [myUser setValue:name forKey:@"Name"];
    NSNumber *initValue = [[NSNumber alloc] initWithInt:-1];
    [myUser setObject: initValue forKey:@"Territory"];
    [myUser setValue:@"Manager" forKey:@"Type"];

    PFObject *obj = [PFObject objectWithClassName:@"Members"];
    obj[@"username"] = self.username.text;
    obj[@"email"] = self.emailAddress.text;
    obj[@"Name"] = name;
    obj[@"Territory"] = initValue;
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error");
        }
    }];

    
    [myUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            
            [controller addAction:defaultAction];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];
    
    
}
- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
