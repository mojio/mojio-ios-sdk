//
//  Engine.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-26.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Engine : JSONModel

@property (nonatomic, strong) NSString* Name;
@property (nonatomic, strong) NSString* Brand;
@property (nonatomic, strong) NSString* MarketingName;
@property (nonatomic, strong) NSString* EngineId;
@property (nonatomic, strong) NSString* Availability;
@property (nonatomic, strong) NSString* Aspiration;
@property (nonatomic, strong) NSString* BlockType;
@property (nonatomic, strong) NSString* Bore;
@property (nonatomic, strong) NSString* CamType;
@property (nonatomic, strong) NSString* Compression;
@property (nonatomic, strong) NSString* Cylinders;
@property (nonatomic, strong) NSString* Displacement;
@property (nonatomic, strong) NSString* FuelInduction;
@property (nonatomic, strong) NSString* FuelQuality;
@property (nonatomic, strong) NSString* FuelType;
@property (nonatomic, strong) NSString* Msrp;
@property (nonatomic, strong) NSString* InvoicePrice;
@property (nonatomic, strong) NSString* MaxHp;
@property (nonatomic, strong) NSString* MaxHpAt;
@property (nonatomic, strong) NSString* MaxPayload;
@property (nonatomic, strong) NSString* MaxTorque;
@property (nonatomic, strong) NSString* MaxTorqueAt;
@property (nonatomic, strong) NSString* OilCapacity;
@property (nonatomic, strong) NSString* OrderCode;
@property (nonatomic, strong) NSString* Redline;
@property (nonatomic, strong) NSString* Stroke;
@property (nonatomic, strong) NSString* ValveTiming;
@property (nonatomic, strong) NSString* Valves;


@end
