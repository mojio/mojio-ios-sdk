//
//  SplashViewController.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-29.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "SplashViewController.h"
#import "MojioClient.h"

@interface SplashViewController ()

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) MojioClient *client;

-(IBAction)loginButtonPressed:(id)sender;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client = [MojioClient client];
    
}

-(IBAction)loginButtonPressed:(id)sender {
    [self.client loginWithCompletionBlock:^{
        [self.delegate didLoginWithController:self];
    }];
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
