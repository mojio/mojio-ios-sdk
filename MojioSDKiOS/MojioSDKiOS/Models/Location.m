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
        self.Lat = latitude;
        self.Lng = longitude;
    }
    
    return self;
}

-(BOOL) isValid {
    return !(isnan(self.Lat) || isnan(self.Lng)) && !(self.Lat == 0 && self.Lng ==0);
}

@end
