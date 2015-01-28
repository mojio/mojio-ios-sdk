//
//  ViewController.m
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-22.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "ViewController.h"
#import "MojioClient.h"
#import <AFOauth2Manager.h>

@interface ViewController ()
@property (nonatomic, strong) MojioClient *client;

@property (strong, nonatomic) IBOutlet UIButton *vehiclesButton;
@property (strong, nonatomic) IBOutlet UIButton *tripsButton;
@property (strong, nonatomic) IBOutlet UIButton *mojiosButton;
@property (strong, nonatomic) IBOutlet UIButton *usersButton;
@property (strong, nonatomic) IBOutlet UIButton *eventsButton;
@property (strong, nonatomic) IBOutlet UIButton *appsButton;

-(IBAction)vehicleButtonPressed:(id)sender;
-(IBAction)tripsButtonPressed:(id)sender;
-(IBAction)mojiosButtonPressed:(id)sender;
-(IBAction)usersButtonPressed:(id)sender;
-(IBAction)appsButtonPressed:(id)sender;
-(IBAction)eventsButtonPressed:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client = [MojioClient sharedInstance];
    [self.client login];
}

-(IBAction)vehicleButtonPressed:(id)sender {
    [self.client getEntity:@"Vehicles" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)tripsButtonPressed:(id)sender {
    [self.client getEntity:@"Trips" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)mojiosButtonPressed:(id)sender {
    [self.client getEntity:@"Mojios" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)usersButtonPressed:(id)sender {
    [self.client getEntity:@"Users" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)appsButtonPressed:(id)sender {
    [self.client getEntity:@"Apps" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)eventsButtonPressed:(id)sender {
    [self.client getEntity:@"Events" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(void) loggedIn {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
