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
@property (nonatomic, strong) SplashViewController *splashController;

@property (strong, nonatomic) IBOutlet UIButton *getEntityButton;
@property (strong, nonatomic) IBOutlet UIButton *updateEntityButton;

-(IBAction)getEntityButtonPressed:(id)sender;
-(IBAction)updateEntityButtonPressed:(id)sender;


@end

@implementation ViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showLogin"]) {
        SplashViewController *splashController = [segue destinationViewController];
        splashController.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client = [MojioClient client];
    [self performSegueWithIdentifier:@"showLogin" sender:nil];
    
}

#pragma mark - crud actions
-(IBAction)getEntityButtonPressed:(id)sender {
    NSDictionary *queryOptions = @{@"limit" : @15, @"sortBy" : @"LastTripEvent"};
//    [self.client getEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Store/samplekey" withQueryOptions:queryOptions success:^(id responseObject) {
//    
//    }failure:^(NSError *failure) {
//        
//    }];
    
//    [self.client getEntityWithPath:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/" withQueryOptions:queryOptions success:nil failure:nil];
    [self.client getEntityWithPath:@"Vehicles/" withQueryOptions:queryOptions success:nil failure:nil];

}

-(IBAction)updateEntityButtonPressed:(id)sender {
    NSString *content = @"\"this is a body\"";
//    self.client updateEntityWithPath:<#(NSString *)#> withContentBody:<#(NSString *)#> success:<#^(void)success#> failure:<#^(void)failure#>
}

#pragma mark - Logging In
- (BOOL) isLoggedIn {
    if (self.client.authToken != nil) {
        return YES;
    }
    return NO;
}

-(void) didLoginWithController:(SplashViewController *)controller {
    [self dismissViewControllerAnimated:controller completion:nil];
}

#pragma mark - Upload/Get Images
- (IBAction)getImageButtonPressed:(id)sender {
    [self.client getImage:@"Vehicles/53cdeca5-b268-4a25-bfde-3938b5cf7d47/Image" success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
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

- (IBAction)logoutButtonPressed:(id)sender {
    [self.client logoutWithCompletionBlock:^{
        [self performSegueWithIdentifier:@"showLogin" sender:nil];
    }];
}

@end
