//
//  ConditionalObserverBase.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Observer.h"

@interface ConditionalObserverBase : Observer

@property (nonatomic, strong) NSString *Timing;


@end
