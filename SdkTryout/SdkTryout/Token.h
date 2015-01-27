//
//  Token.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, scope) {
    basic = 0,
    full =1
};

@interface Token : NSObject

@property (nonatomic) NSUUID *appId;
@property (nonatomic, strong) NSString *apiToken;
@property (nonatomic) NSUUID *userId;
@property (nonatomic, strong) NSDate *validUntil;
@property (nonatomic) enum scope scopes;
@property (nonatomic) BOOL deprecated;

@end
