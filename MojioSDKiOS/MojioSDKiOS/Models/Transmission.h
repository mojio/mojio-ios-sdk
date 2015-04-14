//
//  Transmission.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-26.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Transmission : JSONModel

@property (nonatomic, strong) NSString* Name;
@property (nonatomic, strong) NSString* Brand;
@property (nonatomic, strong) NSString* MarketingName;
@property (nonatomic, strong) NSString* TransmissionId;
@property (nonatomic, strong) NSString* Availability;
@property (nonatomic, strong) NSString* Type;
@property (nonatomic, strong) NSString* DetailType;
@property (nonatomic, strong) NSString* Gears;
@property (nonatomic, strong) NSString* Msrp;
@property (nonatomic, strong) NSString* InvoicePrice;
@property (nonatomic, strong) NSString* OrderCode;


@end
