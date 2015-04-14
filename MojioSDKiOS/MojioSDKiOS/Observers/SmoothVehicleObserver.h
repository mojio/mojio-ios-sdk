//
//  SmoothVehicleObserver.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "SmoothObserverBase.h"

@interface SmoothVehicleObserver : SmoothObserverBase

@property (nonatomic) float InterpolationRate;

@end
