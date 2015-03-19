//
//  MojioClient.m
//  MojioSDKiOS
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import "MojioClient.h"
#import <AFNetworking.h>
#import "JSONModel.h"
#import "AFURLResponseSerialization.h"

@interface MojioClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *baseApiUrl;
@property (copy) void (^ loginCompletionBlock)(void);

@end

@implementation MojioClient

-(id) init {
    self = [super init];
    if (self) {
        self.baseApiUrl = [NSString stringWithFormat:@"https://api.moj.io/v1/"];
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.moj.io/v1/"]];
    }
    return self;
}

+ (id) client {
    static MojioClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme:(NSString *)urlScheme {
  [self initWithAppId:appId andSecretKey:secretKey andRedirectUrlScheme:urlScheme andIsSandbox:NO];
}

- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme:(NSString *)urlScheme andIsSandbox:(BOOL)isSandbox {
    self.appId = appId;
    self.secretKey = secretKey;
    self.redirectUrlScheme = urlScheme;
    self.isSandbox = isSandbox;
}

-(BOOL) isUserLoggedIn {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"MojioAccessToken"] && [defaults doubleForKey:@"MojioTokenExpireTime"] > [NSDate date].timeIntervalSince1970) {
        // Assign the value of the token to the client
        self.authToken = [defaults objectForKey:@"MojioAccessToken"];
        [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
        return YES;
    }
    return NO;
}

-(void) loginWithCompletionBlock:(void (^)(void))completionBlock {
    self.loginCompletionBlock = completionBlock;
    
    if ([self isUserLoggedIn]) {
        self.loginCompletionBlock();
    } else {
        NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io/OAuth2/authorize?response_type=token&client_id=%@&redirect_uri=%@", self.appId, self.redirectUrlScheme];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)logoutWithCompletionBlock:(void (^)(void))completionBlock {
    [[self.manager requestSerializer] setValue:nil forHTTPHeaderField:@"MojioAPIToken"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"MojioAccessToken"];
    [defaults removeObjectForKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
    completionBlock();
}

- (void)handleOpenURL:(NSURL *)url {
    NSDictionary *params = [self parseQueryString:url.absoluteString];
    
    NSString *token = params[@"access_token"];
    NSInteger expires_in = [params[@"expires_in"] integerValue]; //expire time in minutes
    NSTimeInterval expireTime = [NSDate date].timeIntervalSince1970 + expires_in * 60;
    
    self.authToken = token;
    [[self.manager requestSerializer] setValue:_authToken forHTTPHeaderField:@"MojioAPIToken"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"MojioAccessToken"];
    [defaults setObject:@(expireTime) forKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
    
    //Call the login success callback
    self.loginCompletionBlock();
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

-(NSString *) urlEncodedString : (NSDictionary *)dictionary {
    NSMutableString *encodedString = [NSMutableString stringWithFormat:@""];
    for (id key in dictionary) {
        NSString *value = [NSString stringWithFormat:@"%@", key];
        NSString *part = [NSString stringWithFormat:@"%@", [dictionary objectForKey:key]];
        [encodedString appendFormat:@"%@=%@&", value, part];
    }
    // Remove last character as it is &
    [encodedString deleteCharactersInRange:NSMakeRange([encodedString length]-1, 1)];
    return encodedString;
}

-(void) getEntityWithPath:(NSString *)path withQueryOptions:(NSDictionary *)queryOptions success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    self.manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [self.manager GET:path parameters:queryOptions success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (jsonObject != nil) {
                if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                    NSString *type = [jsonObject objectForKey:@"Type"];
                    NSArray *data = [jsonObject objectForKey:@"Data"];
                    if (type != nil) {
                        NSError *err;
                        id object = [[NSClassFromString(type) alloc] initWithDictionary:jsonObject error:&err];
                        if (success != nil) {
                            success(object);
                            return;
                        }
                    } else if (data != nil) {
                        NSMutableArray *jsonObjects = [NSMutableArray array];
                        for (NSDictionary *dict in data) {
                            NSError *err;
                            NSString *type = [dict objectForKey:@"Type"];
                            id object = [[NSClassFromString(type) alloc] initWithDictionary:dict error:&err];
                            [jsonObjects addObject:object];
                        }
                        if (success != nil) {
                            success(jsonObjects);
                            return;
                        }
                    }
                }
            }
            else if (success != nil && responseString != nil) {
                success (responseString);
                return;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (void) updateEntityWithPath:(NSString *)path withContentBody:(NSString *)contentBody success:(void (^)(void))success failure:(void (^)(void))failure {
    
    NSData *data = [contentBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self.manager.baseURL.absoluteString stringByAppendingString:path];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPBody:data];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"PUT"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
        if (success != nil)
            success();
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure();
        }
    }];
    [operation start];
}

-(void) createEntityWithPath:(NSString *)path withContentBody:(NSString *)contentBody success:(void (^)(void))success failure:(void (^)(void))failure {
    NSData *data = [contentBody dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self.manager.baseURL.absoluteString stringByAppendingString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPBody:data];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
        if (success != nil)
            success();
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure();
        }
    }];
    [operation start];
}

-(void) deleteEntityWithPath:(NSString *)path success:(void (^)(void))success failure:(void (^)(void))failure {
    
    [self.manager DELETE:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil)
            success();
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure();
        }
    }];
}

- (void)getImage:(NSString*)path success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self.manager.baseURL.absoluteString stringByAppendingString:path]]];
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    NSMutableSet *acceptableContentTypes = [requestOperation.responseSerializer.acceptableContentTypes mutableCopy];
    [acceptableContentTypes addObject:@"image/jpg"];
    requestOperation.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil)
            success (responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil)
            failure(error);
    }];
    [requestOperation start];
}

- (void)postImage:(NSString*)path image:(UIImage*)image success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[self.manager.baseURL.absoluteString stringByAppendingString:path]]];
    NSString *imageBase64 = [NSString stringWithFormat:@"\"%@\"", [UIImageJPEGRepresentation(image,1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    [request setHTTPBody:[imageBase64 dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:self.authToken forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFCompoundResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON responseObject: %@ ",responseObject);
        if (success != nil)
            success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (failure != nil)
            failure (error);
        
    }];
    [op start];
    
}

@end
