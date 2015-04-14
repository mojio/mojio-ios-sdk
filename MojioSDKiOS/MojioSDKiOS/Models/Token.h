//
//  Token.h
//  Virtual Mechanic
//
//  Created by Ashish Agarwal on 2015-02-04.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Token : JSONModel

@property (nonatomic) NSInteger Type;
@property (nonatomic, strong) NSString *AppId;
@property (nonatomic, strong) NSString *UserId;
@property (nonatomic, strong) NSString *ValidUntil;
@property (nonatomic) NSInteger Scopes;
@property (nonatomic) BOOL Sandboxed;
@property (nonatomic) BOOL Deprecated;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic) BOOL _deleted;

@end
