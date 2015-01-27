//
//  ViewController.m
//  MojioSDK-TestApp
//
//  Created by Vinson Li on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "ViewController.h"
#import "MojioClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MojioClient *client = [[MojioClient alloc] initWithAppId:@"" withSecretKey:@"" withUserOrEmail:@"" withPassword:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
