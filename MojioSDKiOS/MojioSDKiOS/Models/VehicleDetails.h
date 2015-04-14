//
//  VehicleDetails.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-26.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Engine.h"

@interface VehicleDetails : JSONModel

@property (nonatomic, strong) NSString *VIN;
@property (nonatomic, strong) NSString *DateTimeOffset;
@property (nonatomic, strong) NSString *Market;
@property (nonatomic) NSInteger Year;
@property (nonatomic, strong) NSString *Make;
@property (nonatomic, strong) NSString *Model;
@property (nonatomic, strong) NSString *Trim;
@property (nonatomic, strong) NSString *VehicleType;
@property (nonatomic, strong) NSString *BodyType;
@property (nonatomic, strong) NSString *BodySubtype;
@property (nonatomic, strong) NSString *OEMBodyStyle;
@property (nonatomic, strong) NSString *Doors;
@property (nonatomic, strong) NSString *OEMDoors;
@property (nonatomic, strong) NSString *ModelNumber;
@property (nonatomic, strong) NSString *PackageCode;
@property (nonatomic, strong) NSString *DriveType;
@property (nonatomic, strong) NSString *BrakeSystem;
@property (nonatomic, strong) NSString *RestraintType;
@property (nonatomic, strong) NSString *CountryOfManufacture;
@property (nonatomic, strong) NSString *Plant;

@property (nonatomic, strong) Engine *InstalledEngine;
@property (nonatomic, strong) NSArray *Engines;
@property (nonatomic, strong) NSArray *Transmissions;
@property (nonatomic, strong) NSArray *Warranties;
@property (nonatomic, strong) NSString *FuelTankSize;
@property (nonatomic, strong) NSArray *Recalls;
@property (nonatomic, strong) NSArray *ServiceBulletins;


@end
