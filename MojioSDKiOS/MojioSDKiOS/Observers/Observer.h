//
//  Observer.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Observer : JSONModel

@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *ObserverType; // Could be wrong. Could be Integer instead ??
@property (nonatomic, strong) NSString *AppId;
@property (nonatomic, strong) NSString *OwnerId;
@property (nonatomic, strong) NSString *Parent;
@property (nonatomic, strong) NSString *ParentId;
@property (nonatomic, strong) NSString *Subject;
@property (nonatomic, strong) NSString *SubjectId;
@property (nonatomic, strong) NSString* Transports; //always 0
@property (nonatomic, strong) NSString *Status;  // could be string or float instead ??
@property (nonatomic, strong) NSArray *Tokens;
@property (nonatomic, strong) NSString *TimeWindow;
@property (nonatomic) BOOL BroadcastOnlyRecent;
@property (nonatomic, strong) NSString *Throttle;
@property (nonatomic, strong) NSString *NextAllowedBroadcast;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;


@end
