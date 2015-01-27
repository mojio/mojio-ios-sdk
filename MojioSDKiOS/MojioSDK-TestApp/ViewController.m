//
//  ViewController.m
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-22.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "ViewController.h"
#import "MojioClient.h"

@interface ViewController ()
@property (nonatomic, strong) MojioClient *client;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

-(IBAction)loginButtonPressed:(id)sender;
-(IBAction)vehicleButtonPressed:(id)sender;
-(IBAction)eventsButtonPressed:(id)sender;

-(IBAction)oauthLogin:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)loginButtonPressed:(id)sender {
    self.client = [[MojioClient alloc] initWithAppId:@"f642dfb4-67c2-472a-bec6-a583d3152a01" withSecretKey:@"e28b87cc-2d6f-48e0-b4ef-f728c44b2dcf" withUserOrEmail:@"ashisha@moj.io" withPassword:@"Test123"];
    self.client.delegate = self; //assign ourselves as the delegate of the Mojio Client
    
}

-(IBAction)vehicleButtonPressed:(id)sender {
    id response = [self.client getAsync:@"Vehicles" withParams:nil];
}

-(IBAction)eventsButtonPressed:(id)sender {
    id response = [self.client getAsync:@"Trips" withParams:nil];
    
}

-(IBAction)oauthLogin:(id)sender {
//    NSURL *baseURL = [NSURL URLWithString:@"https://api.moj.io/OAuth2Sandbox/authorize"];
//    
//    AFOAuth2Manager *manager = [[AFOAuth2Manager alloc] initWithBaseURL:baseURL clientID:@"f642dfb4-67c2-472a-bec6-a583d3152a01" secret:@"e28b87cc-2d6f-48e0-b4ef-f728c44b2dcf"];
//    
//    NSDictionary *params = @{@"response_type" : @"token", @"client_id" : @"f642dfb4-67c2-472a-bec6-a583d3152a01" ,  @"redirect_uri" : @"mojioios"};
//    //@"client_id" : @"f642dfb4-67c2-472a-bec6-a583d3152a01" ,
//    
//    [manager authenticateUsingOAuthWithURLString:@"https://api.moj.io/OAuth2/authorize" parameters:params success:^(AFOAuthCredential *credential) {
//        NSLog (@"%@", credential.accessToken);
//        
//    }failure:^(NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
}

-(void) loggedIn {
    //
    [self downloadVehicleData];
}

-(void) downloadVehicleData {
    // use mojio client to download vehicle data
    Vehicle *vehicle = [self.client getVehicleData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
