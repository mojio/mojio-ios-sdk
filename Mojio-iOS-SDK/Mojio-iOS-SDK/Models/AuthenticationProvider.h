//
//  AuthenticationProvider.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthenticationProvider : NSObject

@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *providerUserId;

@end
