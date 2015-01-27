//
//  MojioClient.m
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-22.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "MojioClient.h"
#import "App.h"
#import "AFNetworking.h"

@interface MapEntity()

@property(nonatomic, strong) NSMutableDictionary *map;

-(void) add : (id)type withController : (NSString *)controller;
//-(NSString *) typeOfClass : (id)type;

@end

@implementation MapEntity

-(id) init {
    self = [super init];
    if (self) {
        self.map = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) add:(id)type withController:(NSString *)controller {
    [self.map setObject:controller forKey:type];
}


//-(NSString*) typeOfClass:(id)type {
//    if ([self.map objectForKey:type] != nil) {
//        return [self.map objectForKey:type];
//    }
//    
//    for (id key in self.map) {
//        if ([key isKindOfClass:[type class]]) {
//            [self add:type withController:<#(NSString *)#>]
//            
//        }
//    }
//    
//    return nil;
//}

@end

@interface MojioClient ()

@property (nonatomic, strong) MapEntity *map;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *baseApiUrl;

@end

@implementation MojioClient

-(id) init {
    self = [super init];
    if (self) {
        self.baseApiUrl = [NSString stringWithFormat:@"https://api.moj.io/v1/"];
        self.manager = [AFHTTPRequestOperationManager manager];

        if (self.map == nil) {
            self.map = [[MapEntity alloc]init];
            
//            [self.map add:typeof(App) withController:@"apps"];
//            [self.map add:typeof( withController:<#(NSString *)#>]
        }
    }
    return self;
}

-(id) initWithAppId:(NSString *)appId withSecretKey:(NSString *)secretKey withUserOrEmail:(NSString *)userOrEmail withPassword:(NSString *)password {

    self = [super init];
    
    if (self) {
        self.baseApiUrl = [NSString stringWithFormat:@"https://api.moj.io/v1/"];
        self.manager = [AFHTTPRequestOperationManager manager];
        
        NSString *urlString = [NSString stringWithFormat:@"%@/login/%@?secretKey=%@&userOrEmail=%@&password=%@", self.baseApiUrl, appId, secretKey, userOrEmail, password];
        
        [self.manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSLog(@"an error happened");
            }
            else if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                NSString *userID = (NSString *)[responseObject objectForKey:@"UserId"];
//                NSString *mojioApiToken = (NSString*)[responseObject objectForKey:@"_id"];
                
                self.token = [[Token alloc] init];
                [self.token setUserId:(NSUUID*)[responseObject objectForKey:@"UserId"]];
                [self.token setApiToken:(NSString*) [responseObject objectForKey:@"_id"]];
                
                // send message that user is logged in
                [self.delegate loggedIn];

            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error ) {
            NSLog(@"Error is %@", [error localizedDescription]);
        }];
    }
    
    return self;
}

- (Vehicle *) getVehicleData {
    Vehicle *vehicle = [[Vehicle alloc] init];
    
    
    [[self.manager requestSerializer] setValue:self.token.apiToken forHTTPHeaderField:@"MojioAPIToken"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"LastContactTime", @"sortBy", @"true", @"desc", nil];
    NSString *urlString = [NSString stringWithFormat:@"%@/Vehicles", self.baseApiUrl];
    
    [self.manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response is %@", responseObject);
//        [responseObject data]
        
//        NSString *responseString = [responseObject responseString];
        NSArray *data = [responseObject objectForKey:@"Data"];
        NSDictionary *firstObject = [data firstObject];
        
        id typeOfOject = [firstObject objectForKey:@"Type"];
        
        NSString *name = [firstObject objectForKey:@"Name"];
        if (![name isEqual:[NSNull null]]) {
            vehicle.name = name;
        }
        
        NSString *licensePlate = [firstObject objectForKey:@"LicensePlate"];
        
        if (![licensePlate isEqual:[NSNull null]]) {
            vehicle.licensePlate = licensePlate;
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error is %@", [error localizedDescription]);
    }];
    
    return  vehicle;
}

- (id) getAsync : (NSString *)entity withParams : (NSArray *)args {
    
    NSString *request = [self request:args];
    [[self.manager requestSerializer] setValue:self.token.apiToken forHTTPHeaderField:@"MojioAPIToken"];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"LastContactTime", @"sortBy", @"true", @"desc", nil];
    
    MojioResponse *response = [[MojioResponse alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@", self.baseApiUrl, entity, request];
    [self.manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            [response setData:[responseObject objectForKey:@"Data"]];
            
//            [response setContent: (NSString *)responseObject];
            
//            NSArray *data = [responseObject objectForKey:@"Data"];
//            
//            NSString *typeOfEntity = [[data firstObject] objectForKey:@"Type"];
//            
//            if ([typeOfEntity isEqualToString:@"App"]) {
//                
//            }
//            else if ([typeOfEntity isEqualToString:@"Vehicle"]) {
//                
//            }
            
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error is %@", [error localizedDescription]);
        
    }];
    
    return self; // replace this with something proper
}

-(NSString *) request : (NSArray *)params {
    NSMutableString *str = [NSMutableString string];
//    [str appendString:self.baseApiUrl];
    
    //TODO - strip out escape characters from the string
    for (id param in params) {
        if (param!= [NSNull null] && [param isKindOfClass:[NSString class]]) {
            [str appendFormat:@"%@/",param];
        }
    }
    return str;
}

-(void) createVehicle {
    
}

@end
