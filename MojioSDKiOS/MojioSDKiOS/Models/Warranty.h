//
//  Warranty.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-26.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Warranty : JSONModel

@property (nonatomic, strong) NSString* Name;
@property (nonatomic, strong) NSString* Type;
@property (nonatomic, strong) NSString* Months;
@property (nonatomic, strong) NSString* Miles;


@end
