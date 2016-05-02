//
//  TerritoryViewController.m
//  TerritoryAssistant
//
//  Created by Enrique Mitchell on 4/13/16.
//  Copyright © 2016 Enrique Mitchell. All rights reserved.
//

#import "TerritoryViewController.h"
#import <MapKit/MapKit.h>

@interface TerritoryViewController() <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITextField *territoryNumber;
@property (strong, nonatomic) IBOutlet UITextView *territoryNotes;
@property(nonatomic,strong) CLLocationManager *location;


@end
@implementation TerritoryViewController

- (void) viewDidLoad {
    NSLog(@"Did Load called");
    self.location = [[CLLocationManager alloc]init];
    [self.location requestAlwaysAuthorization];
    self.location.delegate = self;
    self.map.delegate = self;
    
    CLLocationCoordinate2D points[5];
    NSLog([self.pt0 stringValue]);
    NSLog([self.pt1 stringValue]);
    NSLog([self.pt2 stringValue]);
    NSLog([self.pt3 stringValue]);
    NSLog([self.pt00 stringValue]);
    NSLog([self.pt01 stringValue]);
    NSLog([self.pt02 stringValue]);
    NSLog([self.pt03 stringValue]);
    
    points[0] = CLLocationCoordinate2DMake([self.pt0 doubleValue], [self.pt00 doubleValue]);
    points[1] = CLLocationCoordinate2DMake([self.pt1 doubleValue], [self.pt01 doubleValue]);
    points[2] = CLLocationCoordinate2DMake([self.pt2 doubleValue], [self.pt02 doubleValue]);
    points[3] = CLLocationCoordinate2DMake([self.pt3 doubleValue], [self.pt03 doubleValue]);
    points[4] = CLLocationCoordinate2DMake([self.pt0 doubleValue], [self.pt00 doubleValue]);
    
    NSLog(@"About to make polygon");
    
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:points count:4];
    [self.map addOverlay: polygon];
    [self.map setRegion:MKCoordinateRegionForMapRect([polygon boundingMapRect])
               animated:YES];
    NSLog(@"End of did lead");
    
    self.territoryNumber.text = self.num;
    self.territoryNotes.text = self.notes;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.enabled = YES;
    pin.canShowCallout = YES;
    return pin;
}

- (MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    renderer.fillColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    renderer.strokeColor = [UIColor cyanColor];
    renderer.lineWidth = 2;
    return renderer;
    
}


@end
