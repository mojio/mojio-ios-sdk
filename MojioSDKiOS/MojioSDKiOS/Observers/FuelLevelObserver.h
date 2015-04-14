//
//  FuelLevelObserver.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ConditionalObserverBase.h"

@interface FuelLevelObserver : ConditionalObserverBase

@property (nonatomic) float FuelLow;
@property (nonatomic) float FuelHigh;

-(id) initWithLowFuelLevel : (float) lowFuel withHighFuelLevel : (float) highFuel withParent : (NSString *)parent withParentId : (NSString *) parentId ;

@end
