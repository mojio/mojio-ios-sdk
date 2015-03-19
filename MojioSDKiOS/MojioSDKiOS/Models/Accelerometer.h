//
//  Accelerometer.h
//  CarO2
//
//  Created by Ming Tang on 2015-03-14.
//  Copyright (c) 2015 Andres Rama. All rights reserved.
//

#import <JSONModel.h>
#import "Trip.h"
#import "Location.h"

@interface Accelerometer : JSONModel

@property (assign, nonatomic) float X;
@property (assign, nonatomic) float Y;
@property (assign, nonatomic) float Z;
@property (assign, nonatomic) float Magnitude;

@end

