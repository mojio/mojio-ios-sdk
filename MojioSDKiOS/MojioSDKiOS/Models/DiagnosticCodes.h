//
//  DTC.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiagnosticCodes : NSObject

// EntityType

@property (nonatomic, strong) NSString *Code;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Source;

// memberwise clone

//DTC Status


@end
