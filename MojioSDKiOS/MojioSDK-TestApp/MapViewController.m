//
//  MapViewController.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-30.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "MapViewController.h"
#import "MojioClient.h"
#import "Observer.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapViewController () <MojioClientDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MojioClient *mojioClient;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mojioClient = [MojioClient client];
    self.mojioClient.mojioClientDelegate = self;
    
    [self drawVehicleOnMap:self.vehicle];
    [self setupVehicleObserver];

}

-(void) drawVehicleOnMap : (Vehicle *) vehicle {
    
    Location *vehicleLocation = vehicle.LastLocation;
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
    [vehicleAnnotation setTitle:vehicle.Name];
    
    [mapView addAnnotation:vehicleAnnotation];
    
    [self.view addSubview:mapView];

}


-(void) setupVehicleObserver {
    
    Observer *vehicleObserver = [[Observer alloc] init];
    [vehicleObserver setName:@"Vehicle Observer"];
    [vehicleObserver setSubject:@"Vehicle"];
    [vehicleObserver setSubjectId:self.vehicle._id];
    [vehicleObserver setTransports:@"SignalR"];
    
    id vehicleJson = [vehicleObserver toJSONString];
    [self.mojioClient createObserverWithBody:vehicleJson withCompletionBlock:^(id responseObject) {
        Observer *observer = (Observer *) responseObject;
        NSString *observerId = [observer _id];
        [self.mojioClient subscribeToObserverWithId:observerId withCompletionBlock:^(id response) {
            // now subscribed to the vehicle observer
        }];
        
    }withFailure:^{
        // do something
    }];
}

-(void) receivedMessageFromMojio:(id)message {
    NSError *err;
    NSString *type = [message objectForKey:@"Type"];
    id object = [[NSClassFromString(type) alloc] initWithDictionary:message error:&err];
    
    if ([object isKindOfClass:[Vehicle class]]) {
        Vehicle *vehicle = (Vehicle *) object;
        [self drawVehicleOnMap:vehicle];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
