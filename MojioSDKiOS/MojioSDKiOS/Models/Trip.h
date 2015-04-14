//
//  Trip.h
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Location.h"
#import "Address.h"

@interface Trip : JSONModel

@property (nonatomic) int Type;
@property (nonatomic, strong) NSString *MojioId;
@property (nonatomic, strong) NSString *StartTime;
@property (nonatomic, strong) NSString *LastUpdatedTime;
@property (nonatomic, strong) NSString *EndTime;
@property (nonatomic) float MaxSpeed;
@property (nonatomic) float MaxAcceleration;
@property (nonatomic, strong) NSNumber *MaxDeceleration;
@property (nonatomic) int MaxRPM;
@property (nonatomic) float FuelLevel;
@property (nonatomic) float FuelEfficiency;
@property (nonatomic) float Distance;
@property (nonatomic, strong) Location *StartLocation;
@property (nonatomic, strong) Location *EndLocation;
@property (nonatomic, strong) Location *LastKnownLocation;
@property (nonatomic, strong) Address *StartAddress;
@property (nonatomic, strong) Address *EndAddress;
@property (nonatomic) BOOL ForcefullyEnded;
@property (nonatomic) float StartMilage;
@property (nonatomic) float EndMilage;
@property (nonatomic) float StartOdometer;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

@end
