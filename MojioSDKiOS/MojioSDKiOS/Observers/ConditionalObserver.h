//
//  ConditionalObserver.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ConditionalObserverBase.h"

@interface ConditionalObserver : ConditionalObserverBase


@property (nonatomic, strong) NSString *Field;
@property (nonatomic) float Threshold1;
@property (nonatomic) float Threshold2;
@property (nonatomic, strong) NSString *Operator1;
@property (nonatomic, strong) NSString *Operator2;
@property (nonatomic, strong) NSString *Conjunction;
@property (nonatomic) BOOL ConditionValue;

@end
