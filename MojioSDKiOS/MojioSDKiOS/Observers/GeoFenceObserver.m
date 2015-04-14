//
//  GeoFenceObserver.m
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-03-31.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "GeoFenceObserver.h"

@implementation GeoFenceObserver

-(id) init {
    self = [super init];
    
    if (self) {
        [self setSubject:@"Vehicle"];
        //
    }
    
    return self;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
