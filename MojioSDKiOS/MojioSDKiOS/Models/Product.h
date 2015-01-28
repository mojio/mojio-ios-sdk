//
//  Product.h
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Product : JSONModel

@property (nonatomic) NSInteger Type;
@property (nonatomic, strong) NSString *AppId;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic) BOOL Shipping;
@property (nonatomic) BOOL Taxable;
@property (nonatomic) float Price;
@property (nonatomic) BOOL Discontinued;
@property (nonatomic, strong) NSString *OwnerId;
@property (nonatomic, strong) NSString *CreationDate;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

@end
