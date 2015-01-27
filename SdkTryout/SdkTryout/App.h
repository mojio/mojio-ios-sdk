//
//  App.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppTypes) {
    web,
    installed
};


@interface App : NSObject

// entity type

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *appDescription;

// Record creation timestamp
@property (nonatomic, strong) NSDate *creationDate;

@property (nonatomic, strong) NSNumber *downloads;

@property (nonatomic, strong) NSArray *redirectUris;

@property (nonatomic) AppTypes applicationType;


@end
