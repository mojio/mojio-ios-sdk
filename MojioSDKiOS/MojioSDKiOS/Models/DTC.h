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

@property (nonatomic) NSInteger Type;

@property (nonatomic, strong) NSString *Code;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Source;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic)BOOL _deleted;

// memberwise clone

//DTC Status


@end
