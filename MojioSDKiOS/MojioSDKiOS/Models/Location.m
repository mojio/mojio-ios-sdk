//
//  Location.m
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "Location.h"
#include <math.h>

@implementation Location

- (id) initWithLat:(double)latitude andLongitude:(double)longitude {
    self = [super init];
    if (self) {
        self.lat = latitude;
        self.lng = longitude;
    }
    
    return self;
}

-(BOOL) isValid {
    return !(isnan(self.lat) || isnan(self.lng)) && !(self.lat == 0 && self.lng ==0);
}

@end
