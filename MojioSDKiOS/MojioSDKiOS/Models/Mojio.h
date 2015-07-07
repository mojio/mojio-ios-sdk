//
//  Mojio_Mojio.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Mojio : JSONModel

@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *VehicleId;
@property (nonatomic, strong) NSString *OwnerId;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Imei;
@property (nonatomic, strong) NSDate *LastContactTime;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

@end
