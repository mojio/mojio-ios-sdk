//
//  Mojio_Mojio.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityType.h"

@interface Mojio_Mojio : NSObject

//TODO fix this ??
@property (nonatomic, readonly) enum entityType _entityType;  // not working in implementation file at this point

@property (nonatomic) NSUUID *ownerId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imei;
@property (nonatomic, strong) NSDate *lastContactTime;

@property (nonatomic) NSUUID *vehicleId;

@end
