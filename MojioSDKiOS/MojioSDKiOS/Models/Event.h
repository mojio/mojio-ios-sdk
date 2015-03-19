//
//  Event.h
//  CarO2
//
//  Created by Ming Tang on 2015-03-14.
//  Copyright (c) 2015 Andres Rama. All rights reserved.
//

#import <JSONModel.h>
#import "Accelerometer.h"
#import "Trip.h"
#import "Location.h"

@interface Event : JSONModel

@property (strong, nonatomic) NSDictionary *Acceleration;
@property (strong, nonatomic) Accelerometer *Accelerometer;
@property (assign, nonatomic) float Altitude;
@property (strong, nonatomic) NSDictionary *BatteryVoltage;
@property (strong, nonatomic) NSDictionary *ConnectionLost;
@property (strong, nonatomic) NSDictionary *Deceleration;
@property (assign, nonatomic) float Distance;
@property (strong, nonatomic) NSString *EventType;
@property (assign, nonatomic) float FuelEfficiency;
@property (assign, nonatomic) float FuelLevel;
@property (assign, nonatomic) float Heading;
@property (strong, nonatomic) Location *Location;
@property (strong, nonatomic) NSString *MojioId;
@property (assign, nonatomic) float Odometer;
@property (strong, nonatomic) NSString *OwnerId;
@property (assign, nonatomic) float RPM;
@property (assign, nonatomic) float Speed;
@property (strong, nonatomic) NSString *Time;
@property (assign, nonatomic) BOOL TimeIsApprox;
@property (strong, nonatomic) NSString *TripId;
@property (strong, nonatomic) NSString *Type;
@property (strong, nonatomic) NSString *VehicleId;
@property (assign, nonatomic) BOOL _deleted;
@property (strong, nonatomic) NSString *_id;

@end

