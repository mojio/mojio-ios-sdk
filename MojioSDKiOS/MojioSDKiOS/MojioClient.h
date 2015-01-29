//
//  MojioClient.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 'MojioClient' is the main class of Mojio SDK.
 */
@interface MojioClient : NSObject

// Initialize the Mojio client
+(id) sharedInstance;

- (void)login;
- (void)logout;
- (void)handleOpenURL:(NSURL *)url;

// Assign the values of the App id, secret key and redirect uri scheme to the client
- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme : (NSString *) urlScheme;

// CRUD methods
-(void) getEntityWithPath:(NSString *)path withQueryOptions:(NSDictionary *)queryOptions success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;

-(void) updateEntityWithPath:(NSString*)path withContentBody : (NSString *)contentBody success : (void(^)(void))success failure : (void(^)(void)) failure;
-(void) createEntityWithPath : (NSString *)path withContentBody : (NSString *)contentBody success : (void (^)(void)) success failure : (void (^)(void))failure;

-(void) deleteEntityWithPath : (NSString *)path success : (void (^)(void)) success failure : (void (^)(void)) failure;

// Download image
- (void)getImage:(NSString*)path success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// Update the Mojio Image
- (void)postImage:(NSString*)path image:(UIImage*)image success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@property (nonatomic) int pageSize;
@property (nonatomic) int sessionTime;

@property (nonatomic, strong) Token *token;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSString *redirectUrlScheme;
@property (nonatomic, strong) NSString *authToken;

@end
