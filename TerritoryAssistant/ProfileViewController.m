//
//  ProfileViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/13/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>

@interface ProfileViewController() <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *emailAddress;
@property (strong, nonatomic) IBOutlet UITextField *currentTerritory;
@property (strong, nonatomic) IBOutlet UIButton *button;


@end

@implementation ProfileViewController

- (void) viewDidLoad {
    self.name.text = self.memberName;
    self.emailAddress.text = self.email;
    if ([self.terrNumber intValue] != -1) {
        self.currentTerritory.text = [self.terrNumber stringValue];
        [self.button setTitle:@"Request Territory" forState:UIControlStateNormal];
    } else {
        self.currentTerritory.text = @"N/A";
        [self.button setTitle:@"Assign Territory" forState:UIControlStateNormal];
    }
}


- (IBAction)assignRequest:(id)sender {
    if ([[self.button titleForState:UIControlStateNormal] isEqualToString:@"Request Territory"]) {
        
        if ([MFMailComposeViewController canSendMail]) {
            NSLog(@"Can send email");
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:@"Return Territory"];
            [mail setMessageBody:@"Please return your territory card at the nearest possible time" isHTML:NO];
            [mail setToRecipients:@[self.emailAddress.text]];
            
            [self presentViewController:mail animated:YES completion:NULL];
        }
        else {
            NSLog(@"This device cannot send email");
        }
    } else {
        //give them a territory
        PFQuery *query = [PFQuery queryWithClassName:@"Members"];
        query = [query whereKey:@"Name" equalTo:self.name.text];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFObject *user = [objects objectAtIndex:0];
                // Pop Up with input
                NSLog(@"About to make the pop up");
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Territory Assignment" message:@"Please enter the new territory number"preferredStyle:UIAlertControllerStyleAlert];
                
                [controller addTextFieldWithConfigurationHandler:^(UITextField *text) {
                }];
                
                UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSLog(@"Action handler");
                    NSString *input = [[[controller textFields] objectAtIndex:0] text];
                    NSLog(@"%@", input);
                    NSNumber *newTerr = [[NSNumber alloc] initWithInt:[input intValue]];
                    [user setValue:newTerr forKey:@"Territory"];
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        if (succeeded) {
                            NSLog(@"Succeeded in updating the territory number");
                        }
                    }];
                }];
                [controller addAction:defaultAction];
                [self presentViewController:controller animated:YES completion:nil];
                
            } else {
                NSLog(@"Error");
            }
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
