//
//  DTC.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTC : NSObject

// EntityType

-(void) setToUnknown;

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *dtcDescription;
@property (nonatomic, strong) NSString *source;

// memberwise clone

//DTC Status


@end
