//
//  EntityType.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, entityType) {
    Token=0,
    Vehicle,
    Storage,
    Product,
    DTC,
    Trip,
    Invoice,
    User,
    Log,
    Observer,
    DeviceLog,
    Subscription,
    Event,
    Mojio,
    App,
    AppApnCertificate,
    SMSEvents,
    MojioPrivate,
    UserPrivate,
    AppPrivate,
    VehiclePrivate,
    VehicleImage,
    MojioReport,
    MojioImage,
    UserImage,
    BaseServiceTask,
    DeviceStats,
    Access,
    AuthorizationToken,
    RefreshToken,
    Address,
    Location,
    SimCard,
    MojioConfiguration,
    MojioUpdate,
    Firmware,
    Operation,
    OperationData
};

@interface EntityType : NSObject

@end
