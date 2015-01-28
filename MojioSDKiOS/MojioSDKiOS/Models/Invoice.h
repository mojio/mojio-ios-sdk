//
//  Invoice.h
//  MojioSDKiOS
//
//  Created by Vinson Li on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "JSONModel.h"

@interface Invoice : JSONModel

@property (assign, nonatomic) NSInteger Type;
@property (strong, nonatomic) NSString *AppId;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *Description;
@property (assign, nonatomic) BOOL Shipping;
@property (assign, nonatomic) BOOL Taxable;
@property (assign, nonatomic) float Price;
@property (assign, nonatomic) BOOL Discontinued;
@property (strong, nonatomic) NSString *OwnerId;
@property (strong, nonatomic) NSDate *CreationDate;
@property (strong, nonatomic) NSString *_id;
@property (assign, nonatomic) BOOL _deleted;

@end
