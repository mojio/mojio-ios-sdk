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

@interface Trips : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *Type;
@property (nonatomic, strong) NSString<Optional> *MojioId;
@property (nonatomic, strong) NSString<Optional> *StartTime;
@property (nonatomic, strong) NSString<Optional> *LastUpdatedTime;
@property (nonatomic, strong) NSString<Optional> *EndTime;
@property (nonatomic, strong) NSNumber<Optional> *MaxSpeed;
@property (nonatomic, strong) NSNumber<Optional> *MaxAcceleration;
@property (nonatomic, strong) NSNumber<Optional> *MaxDeceleration;
@property (nonatomic, strong) NSNumber<Optional> *MaxRPM;
@property (nonatomic, strong) NSNumber<Optional> *FuelLevel;
@property (nonatomic, strong) NSNumber<Optional> *FuelEfficiency;
@property (nonatomic, strong) NSNumber<Optional> *Distance;
@property (nonatomic, strong) Location<Optional> *StartLocation;
@property (nonatomic, strong) Location<Optional> *EndLocation;
@property (nonatomic, strong) Location<Optional> *LastKnownLocation;
@property (nonatomic, strong) Address<Optional> *StartAddress;
@property (nonatomic, strong) Address<Optional> *EndAddress;
@property (nonatomic, strong) NSNumber<Optional> *ForcefullyEnded;
@property (nonatomic, strong) NSNumber<Optional> *StartMilage;
@property (nonatomic, strong) NSNumber<Optional> *EndMilage;
@property (nonatomic, strong) NSNumber<Optional> *StartOdometer;
@property (nonatomic, strong) NSString<Optional> *_id;
@property (nonatomic, strong) NSNumber<Optional> *_deleted;

@end
