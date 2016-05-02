//
//  NewTerritoryViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/30/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "NewTerritoryViewController.h"
#import <Parse/Parse.h>

@interface NewTerritoryViewController ()
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UITextField *pt0;
@property (strong, nonatomic) IBOutlet UITextField *pt1;
@property (strong, nonatomic) IBOutlet UITextField *pt2;
@property (strong, nonatomic) IBOutlet UITextField *pt3;
@property (strong, nonatomic) IBOutlet UITextField *pt00;
@property (strong, nonatomic) IBOutlet UITextField *pt01;
@property (strong, nonatomic) IBOutlet UITextField *pt02;
@property (strong, nonatomic) IBOutlet UITextField *pt03;

@end

@implementation NewTerritoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    NSString *terrNumber = self.number.text;
    NSString *notes = self.notes.text;
    
    PFObject *obj = [PFObject objectWithClassName:@"Territory"];
    NSNumber *lat0 = [[NSNumber alloc] initWithDouble:[self.pt0.text doubleValue]];
    [obj setValue:lat0 forKey:@"Lat0"];
    
    NSNumber *lat1 = [[NSNumber alloc] initWithDouble:[self.pt1.text doubleValue]];
    [obj setValue:lat1 forKey:@"Lat1"];
    
    NSNumber *lat2 = [[NSNumber alloc] initWithDouble:[self.pt2.text doubleValue]];
    [obj setValue:lat2 forKey:@"Lat2"];
    
    NSNumber *lat3 = [[NSNumber alloc] initWithDouble:[self.pt3.text doubleValue]];
    [obj setValue:lat3 forKey:@"Lat3"];
    
    NSNumber *long0 = [[NSNumber alloc] initWithDouble:[self.pt00.text doubleValue]];
    [obj setValue:long0 forKey:@"Long0"];
    
    NSNumber *long1 = [[NSNumber alloc] initWithDouble:[self.pt01.text doubleValue]];
    [obj setValue:long1 forKey:@"Long1"];
    
    NSNumber *long2 = [[NSNumber alloc] initWithDouble:[self.pt02.text doubleValue]];
    [obj setValue:long2 forKey:@"Long2"];
    
    NSNumber *long3 = [[NSNumber alloc] initWithDouble:[self.pt03.text doubleValue]];
    [obj setValue:long3 forKey:@"Long3"];
    
    [obj setValue:terrNumber forKey:@"Number"];
    [obj setValue:notes forKey:@"Notes"];
    [obj setValue:@"N/A" forKey:@"User"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Success");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
    
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
