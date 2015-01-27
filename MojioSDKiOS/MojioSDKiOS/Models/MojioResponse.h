//
//  MojioResponse.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-26.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MojioResponse : NSObject

@property (nonatomic, strong) NSString *errorMessage;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSArray *data;

@end
