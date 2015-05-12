//
//  Vehicle.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-26.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <JSONModel.h>
#import "Trip.h"
#import "Location.h"

@interface Vehicle : JSONModel

@property (strong, nonatomic) Trip *CurrentTrip;
@property (strong, nonatomic) NSDictionary *DiagnosticCodes;
@property (assign, nonatomic) BOOL FaultsDetected;
@property (assign, nonatomic) float FuelLevel;
@property (assign, nonatomic) BOOL IgnitionOn;
@property (assign, nonatomic) float LastAcceleration;
@property (strong, nonatomic) NSDictionary *LastAccelerometer;
@property (assign, nonatomic) float LastAltitude;
@property (strong, nonatomic) NSArray *LastAltitudes;
@property (assign, nonatomic) float LastBatteryVoltage;
@property (strong, nonatomic) NSString *LastContactTime;
@property (assign, nonatomic) float LastDistance;
@property (assign, nonatomic) float LastFuelEfficiency;
@property (assign, nonatomic) float LastHeading;
@property (strong, nonatomic) NSArray *LastHeadings;
@property (strong, nonatomic) Location *LastLocation;
@property (strong, nonatomic) NSString *LastLocationTime;
@property (strong, nonatomic) NSArray *LastLocationTimes;
@property (strong, nonatomic) NSArray *LastLocations;
@property (assign, nonatomic) float LastOdometer;
@property (assign, nonatomic) float LastRpm;
@property (assign, nonatomic) float LastSpeed;
@property (strong, nonatomic) NSArray *LastSpeeds;
@property (strong, nonatomic) NSString *LastTrip;
@property (strong, nonatomic) NSString *LastTripEvent;
@property (assign, nonatomic) float LastVirtualOdometer;
@property (strong, nonatomic) NSString *LicensePlate;
@property (assign, nonatomic) float MilStatus;
@property (strong, nonatomic) NSString *MojioId;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *OwnerId;
@property (strong, nonatomic) NSString *Type;
@property (strong, nonatomic) NSString *VIN;
@property (strong, nonatomic) NSDate *VehicleTime;
@property (strong, nonatomic) NSArray *Viewers;
@property (assign, nonatomic) BOOL _deleted;
@property (strong, nonatomic) NSString *_id;

@end
