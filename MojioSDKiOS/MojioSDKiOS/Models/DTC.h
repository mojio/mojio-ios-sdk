//
//  DTC.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-12.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface DTC : JSONModel

@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *Code;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Source;
@property (nonatomic) BOOL _deleted;
@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *Category;
@property (nonatomic, strong) NSString *Severity;
@property (nonatomic, strong) NSString *Details;

@end
