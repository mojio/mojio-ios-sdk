//
//  MapViewController.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-30.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Location *vehicleLocation = self.vehicle.LastLocation;
    CLLocationCoordinate2D vehicleLocationCoord = CLLocationCoordinate2DMake(vehicleLocation.Lat, vehicleLocation.Lng);
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;
    mapView.showsUserLocation = YES;
    
    // Set the region of the map
    MKCoordinateSpan mapViewSpan = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(vehicleLocationCoord, mapViewSpan);
    [mapView setRegion:mapRegion];
    
    // Add annotation to the map
    MKPointAnnotation *vehicleAnnotation = [[MKPointAnnotation alloc] init];
    [vehicleAnnotation setCoordinate:vehicleLocationCoord];
    [vehicleAnnotation setTitle:self.vehicle.Name];
//    [vehicleAnnotation setSubtitle:self.vehicle.LastLocation.];
    
    [mapView addAnnotation:vehicleAnnotation];
    
    [self.view addSubview:mapView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
