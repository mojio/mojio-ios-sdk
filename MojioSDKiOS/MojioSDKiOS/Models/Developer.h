//
//  Developer.h
//  VirtualMechanic
//
//  Created by Ashish Agarwal on 2015-02-11.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface Developer : JSONModel

@property (nonatomic, strong) NSString *CompanyRole;
@property (nonatomic, strong) NSString *Interest;
@property (nonatomic, strong) NSString *Contact;
@property (nonatomic, strong) NSString *AppType;

@end
