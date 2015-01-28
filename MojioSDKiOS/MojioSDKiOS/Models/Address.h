//
//  Address.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-23.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Address : JSONModel

@property (nonatomic, strong) NSString *Address1;
@property (nonatomic, strong) NSString *Address2;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *State;
@property (nonatomic, strong) NSString *Zip;
@property (nonatomic, strong) NSString *Country;

@end
