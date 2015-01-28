//
//  Location.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Location : JSONModel

@property (nonatomic) double Lat;
@property (nonatomic) double Lng;
@property (nonatomic) BOOL FromLockedGPS;
@property (nonatomic) double Dilution;

@property (nonatomic, readonly) BOOL IsValid;

-(id) initWithLat : (double)latitude andLongitude : (double)longitude;

// method to compare location objects ??

@end
