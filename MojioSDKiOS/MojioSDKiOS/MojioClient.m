//
//  MojioClient.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-22.
//  Copyright (c) 2015 Ashish Agarwal. All rights reserved.
//

#import "MojioClient.h"
#import "App.h"
#import <AFNetworking.h>
#import "JSONModel.h"

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
        self.baseApiUrl = [NSString stringWithFormat:@"https://staging.api.moj.io/v1/"];
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.moj.io/v1/"]];
    }
    return self;
}

+ (id) sharedInstance {
    static MojioClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme:(NSString *)urlScheme {
    self.appId = appId;
    self.secretKey = secretKey;
    self.redirectUrlScheme = urlScheme;
}

-(void) login {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Reuse stored token if it exists and not expired
    if ([defaults objectForKey:@"MojioAccessToken"] && [defaults doubleForKey:@"MojioTokenExpireTime"] > [NSDate date].timeIntervalSince1970) {
        self.authToken = [defaults objectForKey:@"MojioAccessToken"];
        [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
        
    }
    else {
        NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io/OAuth2/authorize?response_type=token&client_id=%@&redirect_uri=%@", self.appId, self.redirectUrlScheme];
        
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)handleOpenURL:(NSURL *)url {
    NSDictionary *params = [self parseQueryString:url.absoluteString];
    
    NSString *token = params[@"access_token"];
    NSInteger expires_in = [params[@"expires_in"] integerValue];
    NSTimeInterval expireTime = [NSDate date].timeIntervalSince1970 + expires_in;
    
    self.authToken = token;
    [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"MojioAccessToken"];
    [defaults setObject:@(expireTime) forKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
    
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSString *paramString = [[query componentsSeparatedByString:@"#"] lastObject];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [paramString componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] >= 2) {
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

// Obsolete call already
-(void) getEntity:(NSString *)entity withQueryOptions:(NSDictionary *)queryOptions withParams:(NSArray *)params success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail {
    
    NSString *request = [self request:params];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",  entity, request];
    
    [self.manager GET:urlString parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSMutableArray *responseObjects = [NSMutableArray array];
        //TODO - check if response is of type array before adding it to the array
        
        for (NSDictionary *dict in [responseObject objectForKey:@"Data"]) {
            NSError *err;
            id object = [[NSClassFromString(entity) alloc] initWithDictionary:dict error:&err];
            [responseObjects addObject:object];
        }
        // check for nil
        success(responseObjects);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        fail(error);
    }];
    
}

-(void) getEntityWithPath:(NSString *)path withQueryOptions:(NSDictionary *)queryOptions success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self.manager GET:path parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSMutableArray *responseObjects = [NSMutableArray array];
        //TODO - check if response is of type array before adding it to the array
        
        for (NSDictionary *dict in [responseObject objectForKey:@"Data"]) {
            NSError *err;
            NSString *type = [dict objectForKey:@"Type"];
            id object = [[NSClassFromString(type) alloc] initWithDictionary:dict error:&err];
            [responseObjects addObject:object];
        }
        // check for nil
        success(responseObjects);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        failure(error);
    }];

}

-(void) deleteEntity:(NSString *)entity withEntityId : (NSString *)entityId withQueryOptions:(NSDictionary *)queryOptions withParams:(NSArray *)params success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    
    NSString *request = [self request:params];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",  entity, entityId, request];
    
    [self.manager DELETE:urlString parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    
}

-(void)updateEntity:(NSString *)entity withQueryOptions:(NSDictionary *)queryOptions withParams:(NSArray *)params success:(void (^)(id))success fail:(void (^)(NSError *))fail {
    
    NSString *request = [self request:params];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",  entity, request];
    
    [self.manager PUT:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

-(NSString *) request : (NSArray *)params {
    NSMutableString *str = [NSMutableString string];
    
//    TODO - strip out escape characters from the string
//    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet];
//    str = [[str componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];

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
