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
#import "SignalR.h"

@interface MojioClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *baseApiUrl;
@property (nonatomic, strong) NSString *productionApiUrl;
@property (nonatomic, strong) NSString *stagingApiUrl;
@property (nonatomic, strong) NSString *developApiUrl;

@property (copy) void (^ loginCompletionBlock)(void);

// For SignalR stuff
//@property (nonatomic, strong) SRHubConnection *hubConnection;
//@property (nonatomic, strong) SRHubProxy *hubProxy;
@property (nonatomic, strong) NSString *signalRUrl;

@end

@implementation MojioClient

-(id) init {
    self = [super init];
    if (self) {
        self.productionApiUrl = @"https://api.moj.io/v1/";
        self.stagingApiUrl = @"https://staging.api.moj.io/v1/";
        self.developApiUrl = @"https://develop.api.moj.io/v1/";
        self.signalRUrl = @"http://api.moj.io:80/v1/signalr";
        
        self.baseApiUrl = self.productionApiUrl;
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
    }
    return self;
}

-(void) switchAppEnvironment : (NSString *) environment {
//    if ([environment isEqualToString:@"develop"])
//        self.baseApiUrl = self.developApiUrl;
//    
//    else if ([environment isEqualToString:@"staging"])
//        self.baseApiUrl = self.stagingApiUrl;
//    
//    else if ([environment isEqualToString:@"production"])
//        self.baseApiUrl = self.productionApiUrl;
//    
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"MojioAccessToken"];
//
//    self.manager = nil;
//    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
//    [[self.manager requestSerializer] setValue:accessToken forHTTPHeaderField:@"MojioAPIToken"];
}

-(void) switchSandbox:(BOOL)sandbox withCompletionBlock:(void (^)(void))completionBlock withFailure:(void (^)(void))failure {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"MojioAccessToken"];
    
    NSString *sandboxEnv;
    if (sandbox)
        sandboxEnv = @"true";
    else
        sandboxEnv = @"false";
    
    NSString *path = [NSString stringWithFormat:@"%@Login/%@/Sandboxed?sandboxed=%@",self.baseApiUrl, accessToken, sandboxEnv];

    [self.manager PUT:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
        if (completionBlock) {
            completionBlock();
        }
    }failure: ^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", [error localizedDescription]);
    }];
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
    self.appId = appId;
    self.secretKey = secretKey;
    self.redirectUrlScheme = urlScheme;
}

-(BOOL) isUserLoggedIn {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"MojioAccessToken"]) { //&& [defaults doubleForKey:@"MojioTokenExpireTime"] > [NSDate date].timeIntervalSince1970
        // Assign the value of the token to the client
        self.authTokenId = [defaults objectForKey:@"MojioAccessToken"];
        [[self.manager requestSerializer] setValue:_authTokenId forHTTPHeaderField:@"MojioAPIToken"];
        
        
        
        return YES;
    }
    return NO;
}

#pragma mark - Login/Logout methods

-(void) saveAuthenticationToken : (id) token  {
    NSString *authToken = [token objectForKey:@"_id"];
    self.authTokenId = authToken;
    [[self.manager requestSerializer] setValue:authToken forHTTPHeaderField:@"MojioAPIToken"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:authToken forKey:@"MojioAccessToken"];
    [defaults setObject:[token objectForKey:@"UserId"] forKey:@"UserId"];
    [defaults synchronize];

}

-(void) loginWithCompletionBlock:(void (^)(void))completionBlock {
    self.loginCompletionBlock = completionBlock;
    
    if ([self isUserLoggedIn]) {
        if (self.loginCompletionBlock) {
            self.loginCompletionBlock();
        }
    } else {
        NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io/OAuth2SandBox/authorize?response_type=token&client_id=%@&redirect_uri=%@", self.appId, self.redirectUrlScheme];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)loginUserWithUsername:(NSString *)username withPassword:(NSString *)password withCompletionBlock:(void (^)(id))completionBlock failure:(void (^)(void))failure {
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
    NSString *url = [NSString stringWithFormat:@"%@Login/%@?secretKey=%@&userOrEmail=%@&password=%@", self.baseApiUrl, self.appId, self.secretKey, username, password];
    
    [loginManager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self saveAuthenticationToken:responseObject];
        
        if (completionBlock)
            completionBlock(responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", [error localizedDescription]);
        if (failure)
            failure();
    }];
}

-(void) loginExternalUserWithAccessToken:(NSString *)accessToken success:(void (^)(id))success failure:(void (^)(void))failure {
    
    //TODO : Need authentication token when logged in from facebook
    
    AFHTTPRequestOperationManager *loginManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
    
    AFHTTPRequestOperationManager *registerAppManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
    NSString *path = [self.baseApiUrl stringByAppendingFormat:@"Login/%@?secretKey=%@", self.appId, self.secretKey];
    
    
    [registerAppManager POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *tokenId = [responseObject objectForKey:@"_id"];
        
        [[loginManager requestSerializer] setValue:tokenId forHTTPHeaderField:@"MojioAPIToken"];
        [loginManager POST:[self.baseApiUrl stringByAppendingFormat:@"Login/ExternalUser?accessToken=%@", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
            [[self.manager requestSerializer] setValue:[response objectForKey:@"_id"] forHTTPHeaderField:@"MojioAPIToken"];
            [self saveAuthenticationToken:response];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:accessToken forKey:@"MojioFacebookAccessToken"];
            [defaults synchronize];
            
            if (success) {
                success(response);
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            NSLog(@"%@", [err localizedDescription]);
            if (failure) {
                failure();
            }
        }];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)logoutWithCompletionBlock:(void (^)(void))completionBlock {
    [[self.manager requestSerializer] setValue:nil forHTTPHeaderField:@"MojioAPIToken"];
    
    // remove all objects from the NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaultsDict = [defaults dictionaryRepresentation];
    for (id key in defaultsDict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    if (completionBlock) {
        completionBlock();
    }
}

-(void) signUpUserWithEmail:(NSString *)email withPassword:(NSString *)password withCompletionBlock:(void (^)(id))completionBlock withFailure:(void (^)(void))failure {
    
    NSDictionary *user = @{@"Email" : email, @"Password" : password};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error:nil];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Users", self.baseApiUrl]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperationManager *registerAppManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
    NSString *path = [self.baseApiUrl stringByAppendingFormat:@"Login/%@?secretKey=%@", self.appId, self.secretKey];
    
    // Register the app
    [registerAppManager POST:path parameters:nil success:^(AFHTTPRequestOperation *registerOp, id responseObject) {
        NSString *token = [responseObject objectForKey:@"_id"];
        [request setValue:token forHTTPHeaderField:@"MojioAPIToken"];
        
        // Register the user with Mojio
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFCompoundResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
            
            // Log the user in
            AFHTTPRequestOperationManager *loginOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.baseApiUrl]];
            NSString *url = [NSString stringWithFormat:@"%@Login/%@?secretKey=%@&userOrEmail=%@&password=%@", self.baseApiUrl, self.appId, self.secretKey, email, password];
            [loginOperationManager POST:url parameters:nil success:^(AFHTTPRequestOperation *loginOperation, id loginResponse) {
                [self saveAuthenticationToken:loginResponse];
                if (completionBlock)
                    completionBlock(loginResponse);
                
            }failure:^(AFHTTPRequestOperation *loginOperation, NSError *loginError) {
                NSLog(@"Login operation failed with error: %@", [loginError localizedDescription]);
            }];
            

        }failure:^(AFHTTPRequestOperation *op, NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
            if (failure != nil) {
                failure();
            }
        }];
        [operation start];
        
    }failure:^(AFHTTPRequestOperation *registerOp, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void)handleOpenURL:(NSURL *)url {
    NSDictionary *params = [self parseQueryString:url.absoluteString];
    
    NSString *token = params[@"access_token"];
    NSInteger expires_in = [params[@"expires_in"] integerValue]; //expire time in minutes
    NSTimeInterval expireTime = [NSDate date].timeIntervalSince1970 + expires_in * 60;
    
    self.authTokenId = token;
    [[self.manager requestSerializer] setValue:_authTokenId forHTTPHeaderField:@"MojioAPIToken"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"MojioAccessToken"];
    [defaults setObject:@(expireTime) forKey:@"MojioTokenExpireTime"];
    [defaults synchronize];
    
    //Call the login success callback
    if (self.loginCompletionBlock) {
        self.loginCompletionBlock();
    }
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

#pragma mark - URL Encoding parameters
//needed for encoding query parameters in NSMutableURLRequest

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

-(NSString*) urlEncodedString : (NSDictionary *) dictionary {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dictionary) {
        id value = [dictionary objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

#pragma mark - CRUD methods

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
    [request setValue:self.authTokenId forHTTPHeaderField:@"MojioAPIToken"];
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
    [request setValue:self.authTokenId forHTTPHeaderField:@"MojioAPIToken"];
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

-(void) getAllObserversWithCompletionBlock:(void (^)(id))completionBlock withFailure:(void (^)(NSError *error))failure {
    
    [self.manager GET:@"Observers" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dataArray = [responseObject objectForKey:@"Data"];
        NSMutableArray *data = [NSMutableArray array];
        
        for (NSDictionary *dict in dataArray) {
            NSError *err;
            NSString *type = [dict objectForKey:@"Type"];
            id object = [[NSClassFromString(type) alloc] initWithDictionary:dict error:&err];
            [data addObject:object];
        }
        if (completionBlock) {
            completionBlock(data);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error in retrieving observers: %@", [error localizedDescription]);
        if (failure) {
            failure(error);
        }
    }];
}

-(void) createObserverWithBody:(NSString *)body withCompletionBlock:(void (^)(id))completionBlock withFailure:(void (^)(void))failure {
    [self createOrUpdateObserver:@"create" withBody:body withCompletionBlock:completionBlock withFailure:failure];
}

-(void) updateObserverWithBody:(NSString *)body withCompletionBlock:(void (^)(id))completionBlock withFailure:(void (^)(void))failure {
    [self createOrUpdateObserver:@"update" withBody:body withCompletionBlock:completionBlock withFailure:failure];
}

-(void) createOrUpdateObserver : (NSString *)createOrUpdate withBody : (NSString *)body withCompletionBlock : (void(^)(id)) completionBlock withFailure : (void(^)(void)) failure {
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [self.manager.baseURL.absoluteString stringByAppendingString:@"Observers"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPBody:data];
    [request setValue:self.authTokenId forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    
    if ([createOrUpdate isEqualToString:@"update"])
        [request setHTTPMethod:@"PUT"];
    
    else
        [request setHTTPMethod:@"POST"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFCompoundResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject){
        if ([responseObject isKindOfClass:[NSData class]]) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSString *type = [jsonObject objectForKey:@"Type"];
            NSString *observerType = [jsonObject objectForKey:@"ObserverType"];
            if (type != nil && observerType != nil) {
                NSError *err;
                id object;
                if ([observerType isEqualToString:@"Generic"]) {
                    object = [[NSClassFromString(type) alloc] initWithDictionary:jsonObject error:&err];
                }
                else {
                    observerType = [observerType stringByAppendingString:@"Observer"];
                    object = [[NSClassFromString(observerType) alloc] initWithDictionary:jsonObject error:&err];
                }
                
                if (completionBlock != nil)
                    completionBlock(object);
                
            }
            
        }
    }failure:^(AFHTTPRequestOperation *op, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        if (failure != nil) {
            failure();
        }
    }];
    [operation start];

}

-(void) deleteObserverWithId:(NSString *)observerId withCompletionBlock:(void (^)(void))completionBlock withFailure:(void (^)(void))failure {
    
    NSString *path = [NSString stringWithFormat:@"Observers/%@", observerId];
    [self.manager DELETE:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            completionBlock();
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

-(void) subscribeToObserverWithId : (NSString *)observerId withCompletionBlock:(void(^)(id responseObject))completionBlock {
    
    SRHubConnection *hubConnection;
    SRHubProxy *hubProxy;
    
    hubConnection = [SRHubConnection connectionWithURL:self.signalRUrl];
    hubProxy = [hubConnection createHubProxy:@"ObserverHub"];
    [hubProxy on:@"UpdateEntity" perform:self selector:@selector(incomingMessageStream:)];
    [hubProxy on:@"Error" perform:self selector:@selector(errorInSignalRConnection:)];

    [hubConnection start];
    
    hubConnection.started = ^{
        NSArray *argsArray = @[observerId];
        [hubProxy invoke:@"Subscribe" withArgs:argsArray completionHandler:^(id responseObject) {
            if (completionBlock) {
                completionBlock(responseObject);
            }

            if (responseObject) {
                [self.mojioClientDelegate invokedConnectionToMojioWithResponse:responseObject];
            }
            
//            else
//                [self.mojioClientDelegate invokedConnectionToMojioWithResponse:nil];
        }];
    };
}

-(void) incomingMessageStream : (id) message {
    [self.mojioClientDelegate receivedMessageFromMojio:message];
}

-(void) errorInSignalRConnection : (id) error {
    [self.mojioClientDelegate errorInConnectingToMojio:error];
}


// imageSize should be 50, 100 or 200
- (void)getImage:(NSString*)path withImageSize :(NSInteger)imageSize success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    if (imageSize)
        path = [NSString stringWithFormat:@"%@%@?size=%ld", self.manager.baseURL.absoluteString, path, imageSize];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [request setValue:self.authTokenId forHTTPHeaderField:@"MojioAPIToken"];

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
    
    [request setValue:self.authTokenId forHTTPHeaderField:@"MojioAPIToken"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld",(unsigned long)request.HTTPBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"PUT"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFCompoundResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success != nil)
            success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        if (failure != nil)
            failure (error);
    }];
    [op start];
}

-(void) cancelAllRequests
{
    [[self.manager operationQueue] cancelAllOperations];
}

@end
