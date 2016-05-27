# mojio-ios-sdk (Under Active Development)

## Installing the SDK from Cocoapods

Step 1: Add MojioSDK as a pod to your Podfile <br/>
```
pod 'MojioSDK'
```
Step 2: Install or update your Pods <br/>
```
pod install or pod update
```

## Using the SDK

## Initializing Auth & Rest Clients (Swift)
```
import MojioSDK

self.authClient = MojioSDK.AuthClient.init(clientId: <CLIENT_ID>, clientSecretKey:  <CLIENT_SECRET>, clientRedirectURI: <CLIENT_REDIRECT_URI>)

self.restClient : RestClient = RestClient.init(clientEnvironment: ClientEnvironment.SharedInstance)
```

## Initializing Auth & Rest Clients (Objective-C)
```
import "MojioSDK-Swift.h"

self.authClient = [[AuthClient alloc] initWithClientId:<CLIENT_ID> clientSecretKey:<CLIENT_SECRET> clientRedirectURI:<CLIENT_REDIRECT_URI>];

self.restClient = [[RestClient alloc] initWithClientEnvironment:[ClientEnvironment SharedInstance]];1
```

## Authenticating a user

#### Logging In/Out (Swift)
```
self.authClient.login({
    // Callback is executed once the user is logged in
}]);

self.authClient.logout()
```

#### Logging In/Out (Objective-C)
```
[self.authClient login:^{
    // Block is executed once the user is logged in
}];

[self.authClient logout];
```

## Fetching Data

#### In Swift
```
self.restClient.get().vehicles().query(top: <TOP_OFFSET>, skip: <SKIP_COUNT>, filter: <FILTER>, select: <SELECT>, orderby: <ORDER-BY>).run(
    {
        response in
        // Executed when the data is successfully fetched
    }, failure:
    {
        error in
        // Executed if there was an error in trying to retrieve data
    }
)
```
#### In Objective-C
```
[[restClient get] vehicles:nil] query:<TOP_OFFSET> skip:<SKIP_COUNT> filter:<FILTER> select:<SELECT> orderby:<ORDER-BY>] run:^(id response) {
    // Executed when the data is successfully fetched
} failure:^(NSString * error) {
    // Executed if there was an error in trying to retrieve data
}];
```

## Getting a specific entity

#### In Swift
```
self.restClient.get().vehicles(<VEHICLE_ID>).run(
    {
        response in
        // Executed when the data is successfully fetched
    }, failure:
    {
        error in
        // Executed if there was an error in trying to retrieve data
    }
)
```

#### In Objective-C
```
[[restClient get] vehicles:<VEHICLE_ID>] run:^(id response) {
    // Executed when the data is successfully fetched
} failure:^(NSString * error) {
    // Executed if there was an error in trying to retrieve data
}];
```

## Saving an existing entity

#### In Swift
```
self.restClient.put().vehicles(<VEHICLE_ID>).run(vehicle.json(), completion:
    {
        response in
        // Executed when the data is successfully fetched
    }, failure:
    {
        error in
        // Executed if there was an error in trying to retrieve data
    }
)
```

#### In Objective-C
```
[[restClient put] vehicles:<VEHICLE_ID>] run:vehicle.json(), completion:^(id response) {
    // Executed when the data is successfully fetched
} failure:^(NSString * error) {
    // Executed if there was an error in trying to retrieve data
}];
```

## Deleting an existing entity

#### In Swift
```
self.restClient.delete().vehicles(<VEHICLE_ID>).run(
    {
        response in
        // Executed when the data is successfully fetched
    }, failure:
    {
        error in
        // Executed if there was an error in trying to retrieve data
    }
)
```

#### In Objective-C
```
[[restClient delete] vehicles:<VEHICLE_ID>] run:^(id response) {
    // Executed when the data is successfully fetched
} failure:^(NSString * error) {
    // Executed if there was an error in trying to retrieve data
}];
```
