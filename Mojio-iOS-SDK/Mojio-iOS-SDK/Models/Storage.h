//
//  Storage.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Storage : NSObject

@property (nonatomic) NSUUID *ownerAppId;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSString *controller;
@property (nonatomic, strong) NSString *entityId;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

@end
