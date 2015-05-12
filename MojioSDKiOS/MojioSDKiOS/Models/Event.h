//
//  Event.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-19.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "DTC.h"
//#import "Accelerometer.h"
#import "Location.h"




@interface Event : JSONModel

@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *MojioId;
@property (nonatomic, strong) NSString *VehicleId;
@property (nonatomic, strong) NSString *OwnerId;
@property (nonatomic, strong) NSString *EventType;
@property (nonatomic, strong) NSString *Time;
@property (nonatomic, strong) Location *Location;
//@property (nonatomic, strong) Accelerometer *Accelerometer;
@property (nonatomic) BOOL TimeIsApprox;
@property (nonatomic) float BatteryVoltage;
@property (nonatomic) BOOL ConnectionLost;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

// TODO: Need a better way to deserialize the event types using JSONModel
@property (nonatomic, strong) NSArray *DTCs;

@end
