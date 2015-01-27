//
//  Location.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic) double lat;
@property (nonatomic) double lng;
@property (nonatomic) BOOL fromLockedGPS;
@property (nonatomic) double dilution;

@property (nonatomic, readonly) BOOL isValid;

-(id) initWithLat : (double)latitude andLongitude : (double)longitude;

// method to compare location objects ??

@end
