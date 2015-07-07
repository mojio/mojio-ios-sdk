//
//  MojioClient.h
//  SdkTryout
//
//  Created by Ashish Agarwal on 2015-01-27.
//  Copyright (c) 2015 Mojio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Token.h"

@class MojioClient;
@protocol MojioClientDelegate <NSObject>

@optional
-(void) receivedMessageFromMojio : (id) message;
-(void) errorInConnectingToMojio : (id) error;
-(void) invokedConnectionToMojioWithResponse : (id) message;

@end

typedef enum EventType {
    Log = 1, //Server side diagnostics
    Message = 2, // Mojio communication session
    Information = 100,
    MojioOn = 101,
    MojioIdle = 102,
    MojioWake = 103,
    IgnitionOn = 104,
    IgnitionOff = 105,
    MojioOff = 106,
    LowBattery = 107,
    TripEvent = 1005, //GPS Update
    FenceEntered = 1006,
    FenceExited = 1007,
    TripStatus = 1010,
    Warning = 30000,
    MILWarning = 30001,
    ConnectionLost = 40000,
    Alert = 100000,
    Accident = 100001,
    TowStart = 100002,
    TowStop = 100003,
    HardAcceleration = 100004,
    HardBrake = 100005,
    HardRight = 100006,
    HardLeft = 100007,
    Speed = 100008, // Mojio defined excessive speed
    Diagnostic = 100009,
    OffStatus = 100010,
    Park = 100011,
    Accelerometer = 100012,
    Acceleration = 100013,
    Deceleration = 100014,
    HeadingChange = 100015,
    Mileage = 100016,
    LowFuel = 100017,
    RPM = 100018,
    MovementStart = 100019,
    MovementStop = 100020,
    HeartBeat = 100021,
    DeviceDiagnostic = 100022,
    IdleEvent = 100023,
    PreSleepWarning = 100024,
    Unknown = -1
    
} EventType;

/**
 'MojioClient' is the main class of Mojio SDK.
 */
@interface MojioClient : NSObject

// Initialize the Mojio client
+(id) client;

- (void)handleOpenURL:(NSURL *)url;

// Assign the values of the App id, secret key and redirect uri scheme to the client
- (void) initWithAppId : (NSString *) appId andSecretKey : (NSString *)secretKey andRedirectUrlScheme : (NSString *) urlScheme;

// Switch App environments between develop-staging-production
-(void) switchAppEnvironment : (NSString *) environment;

-(void) switchSandbox : (BOOL) sandbox withCompletionBlock : (void(^)(void)) completionBlock withFailure :(void(^)(void))failure;

// Login Methods
- (BOOL)isUserLoggedIn;
- (void)loginWithCompletionBlock : (void(^)(void))completionBlock;
- (void)logoutWithCompletionBlock : (void(^)(void))completionBlock;
-(void) loginExternalUserWithAccessToken : (NSString *)accessToken success : (void(^)(id responseObject))success failure : (void(^)(void)) failure;
-(void) loginUserWithUsername : (NSString *)username withPassword : (NSString *)password withCompletionBlock : (void(^)(id response))completionBlock failure : (void(^)(void)) failure ;
-(void) signUpUserWithEmail : (NSString *)email withPassword : (NSString *)password withCompletionBlock : (void(^)(id responseObject))completionBlock withFailure : (void(^)(void))failure;

// CRUD methods
-(void) getEntityWithPath:(NSString *)path withQueryOptions:(NSDictionary *)queryOptions success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;

-(void) updateEntityWithPath:(NSString*)path withContentBody : (NSString *)contentBody success : (void(^)(void))success failure : (void(^)(void)) failure;
-(void) createEntityWithPath : (NSString *)path withContentBody : (NSString *)contentBody success : (void (^)(void)) success failure : (void (^)(void))failure;

-(void) deleteEntityWithPath : (NSString *)path success : (void (^)(void)) success failure : (void (^)(void)) failure;

// Observers
-(void) getAllObserversWithCompletionBlock : (void(^)(id responseObject))completionBlock withFailure : (void(^)(NSError *error))failure;
-(void) createObserverWithBody : (NSString *)body withCompletionBlock : (void(^)(id responseObject)) completionBlock withFailure : (void(^)(void)) failure;
-(void) updateObserverWithBody : (NSString *)body withCompletionBlock : (void(^)(id responseObject)) completionBlock withFailure : (void(^)(void)) failure;
-(void) deleteObserverWithId : (NSString *)observerId withCompletionBlock : (void(^)(void)) completionBlock withFailure : (void(^)(void)) failure;
-(void) subscribeToObserverWithId : (NSString *)observerId withCompletionBlock:(void(^)(id responseObject))completionBlock;

@property(nonatomic, strong) id <MojioClientDelegate> mojioClientDelegate;

//-(void) create

// Download image
- (void)getImage:(NSString*)path withImageSize :(NSInteger)imageSize success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// Update the Mojio Image
- (void)postImage:(NSString*)path image:(UIImage*)image success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@property (nonatomic) int pageSize;
@property (nonatomic) int sessionTime;

@property (nonatomic, strong) Token *authToken;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSString *redirectUrlScheme;
@property (nonatomic, strong) NSString *authTokenId;


-(void) cancelAllRequests;

@end
