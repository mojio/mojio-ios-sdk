//
//  ApnObserverToken.h
//  CarAlarm
//
//  Created by Ashish Agarwal on 2015-04-22.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObserverToken.h"

@interface ApplePushObserverToken : ObserverToken

@property (nonatomic, strong) NSString *DeviceToken;
@property (nonatomic, strong) NSString *AlertBody;
@property (nonatomic, strong) NSString *AlertSound;

@end
