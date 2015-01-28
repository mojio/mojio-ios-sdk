//
//  Users.h
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Users : JSONModel

@property (nonatomic) float Type;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *FirstName;
@property (nonatomic, strong) NSString *LastName;
@property (nonatomic, strong) NSString *Email;
@property (nonatomic) float UserCount;
@property (nonatomic) float Credits;
@property (nonatomic, strong) NSString *CreationDate;
@property (nonatomic, strong) NSString *LastActivityDate;
@property (nonatomic, strong) NSString *LastLoginDate;
@property (nonatomic, strong) NSString *Locale;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

@end
