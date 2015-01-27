//
//  Vehicle.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-26.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property (nonatomic) NSInteger type;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *mojioId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *vin;
@property (nonatomic, strong) NSString *licensePlate;
@property (nonatomic) BOOL ignitionOn;

// location object

@property (nonatomic) float lastSpeed;
@property (nonatomic) float fuelLevel;
@property (nonatomic) float lastFuelEfficiency;
@property (nonatomic) float lastRPM;

@property (nonatomic) BOOL milStatus;

@property (nonatomic, strong) NSString *vehicleId;

@end
