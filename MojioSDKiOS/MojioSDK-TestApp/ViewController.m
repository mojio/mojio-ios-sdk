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
@property (strong, nonatomic) IBOutlet UIButton *deleteTripsButton;
@property (strong, nonatomic) IBOutlet UIButton *updateTripsButton;
@property (strong, nonatomic) IBOutlet UIButton *createEntityButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteEntityButton;


-(IBAction)vehicleButtonPressed:(id)sender;
-(IBAction)tripsButtonPressed:(id)sender;
-(IBAction)mojiosButtonPressed:(id)sender;
-(IBAction)usersButtonPressed:(id)sender;
-(IBAction)appsButtonPressed:(id)sender;
-(IBAction)eventsButtonPressed:(id)sender;
-(IBAction)deleteTripsButtonPressed:(id)sender;
-(IBAction)updateTripsButtonPressed:(id)sender;
-(IBAction)createEntityButtonPressed:(id)sender;
-(IBAction)deleteEntityButtonPressed:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client = [MojioClient client];
    [self.client login];
}

- (BOOL) isLoggedIn {
    
    return NO;
}

-(IBAction)vehicleButtonPressed:(id)sender {
    [self.client getEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Store/newkey/" withQueryOptions:nil success:nil failure:nil];
}

-(IBAction)tripsButtonPressed:(id)sender {
//    [self.client getEntity:@"Trips" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)mojiosButtonPressed:(id)sender {
//    [self.client getEntity:@"Mojios" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)usersButtonPressed:(id)sender {
//    [self.client getEntity:@"Users" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)appsButtonPressed:(id)sender {
//    [self.client getEntity:@"Apps" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)eventsButtonPressed:(id)sender {
//    [self.client getEntity:@"Events" withQueryOptions:nil withParams:nil success:nil fail:nil];
}

-(IBAction)deleteTripsButtonPressed:(id)sender {
//    NSDictionary *options = @{@"id" : @"e08fff30-6e58-4f3b-a1b2-78b429b04199"};
    NSArray *params = [NSArray arrayWithObjects:@"Store", @"sample", nil];
//    [self.client deleteEntity:@"Vehicles" withEntityId:@"a862ef4d-f4f6-433a-a781-4444237fb5f9" withQueryOptions:nil withParams:params success:nil fail:nil];
}

-(IBAction)updateTripsButtonPressed:(id)sender {

    NSString *content = @"\"There you go, this is finally working !!\"";
    [self.client updateEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Store/samplekey" withContentBody:content success:nil failure:nil];
    
}

-(IBAction)createEntityButtonPressed:(id)sender {
    NSString *content = @"\"This is the value for the specified key\"";
    [self.client createEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Store/newkey" withContentBody:content success:nil failure:nil];
}

- (IBAction)getImageButtonPressed:(id)sender {
    [self.client getImage:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Image" success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(IBAction)deleteEntityButtonPressed:(id)sender {
    [self.client deleteEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Store/newkey" success:nil failure:nil];
}

- (IBAction)uploadImageButtonPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"logo"];
    
    CGRect rect = CGRectMake(0,0,300,300);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    [self.client postImage:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Image" image:img success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];

}

- (IBAction)loginButtonPressed:(id)sender {
    [self.client login];
}

- (IBAction)logoutButtonPressed:(id)sender {
    [self.client logout];
}

@end
