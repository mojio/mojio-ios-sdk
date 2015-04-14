//
//  ServiceBulletin.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-18.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ServiceBulletin : JSONModel

@property (nonatomic, strong) NSString *ItemNumber;
@property (nonatomic, strong) NSString *BulletinNumber;
@property (nonatomic, strong) NSString *ReplacementBulletinNumber;
@property (nonatomic, strong) NSString *DateAdded;
@property (nonatomic, strong) NSString *Component;
@property (nonatomic, strong) NSString *BulletinDate;
@property (nonatomic, strong) NSString *Summary;

@end
