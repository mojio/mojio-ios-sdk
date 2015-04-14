//
//  FuelLevelObserver.m
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "FuelLevelObserver.h"

@implementation FuelLevelObserver

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(id) initWithLowFuelLevel:(float)lowFuel withHighFuelLevel:(float)highFuel withParent:(NSString *)parent withParentId:(NSString *)parentId {
    self = [ super init];
    if (self) {
        self.ParentId = parentId;
        self.Parent = parent;
        self.FuelLow = lowFuel;
        self.FuelHigh = highFuel;
    }
    
    return self;
}

@end
