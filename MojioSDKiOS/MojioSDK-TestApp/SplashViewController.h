//
//  SplashViewController.h
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-29.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashViewController;
@protocol SplashControllerDelegate <NSObject>

-(void)didLoginWithController : (SplashViewController *)controller;

@end

@interface SplashViewController : UIViewController

@property (nonatomic, weak) id <SplashControllerDelegate> delegate;

@end
