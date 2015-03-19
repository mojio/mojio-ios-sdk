# mojio-ios-sdk

## Initializing the SDK 

```
self.client = [MojioClient client];
[self.client initWithAppId:[APP_ID] andSecretKey:[SECRET_KEY] andRedirectUrlScheme:[REDIRECT_SCHEME] andIsSandbox:[YES for sandbox mode, NO for live]];
```

## Authenticating a user

#### Logging In
```
[self.client loginWithCompletionBlock:^{
        // this is executed once the user is logged in
    }];
```
In addition, the application needs to be able to receive the authentication token when the Mojio server redirects it to the app. To do this, add the following lines of code to the app's ApplicationDelegate.m file:
```
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [self.client handleOpenURL:url];
    return YES;
}
```
#### Logging out
```
[self.client logoutWithCompletionBlock:^{
  // code is executed as soon as the user logs out
}];
```
## Fetching Data
```
NSDictionary *queryOptions = @{@"limit" : @1, @"offset" : @0, @"sortBy" : @"LastContactTime", @"desc" : @"true"};
  [self.client getEntityWithPath:@"Vehicles" withQueryOptions:queryOptions success:^(id responseObject) {
    // executed when the data is successfully fetched
  }failure: ^{
    // executed if there was an error in trying to retrieve data
  }];
```

## Getting a specific entity

```
[self.client getEntityWithPath:@"Vehicles/[VEHICLE_ID]" withQueryOptions:queryOptions success:^(id responseObject) {
  // executed when the data is successfully fetched
}failure: ^{
  // executed if there was an error in trying to retrieve data
}];
```

## Saving an existing entity
```
[self.client updateEntityWithPath:@"Vehicles/{id}/Store/{key}" withContentBody: [CONTENT] success:^{
  // executed if the response is 200 or 201
} failure: ^{
  // executed if the request failed
}
```

## Deleting an existing entity
```
[self.client deleteEntityWithPath:@"Vehicles/{id}/Store/{key}" success:^{
  // executed if the entity is deleted
} failure:^{
  // executed if the request failed
}
```
