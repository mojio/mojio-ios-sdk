//
//  LoginTest.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest

@testable import MojioSDK

class AuthenticationTests: XCTestCase {
    
    let authClient : AuthClient = AuthClient(clientId: "<CLIENT_ID>", clientSecretKey: "<CLIENT_SECRET>", clientRedirectURI: "sdkdev://io.moj")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.authClient.logout()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndpoints ()  {
        let apiEndpoint : String = ClientEnvironment.SharedInstance.getApiEndpoint()
        let apiV1Endpoint : String = ClientEnvironment.SharedInstance.getV1ApiEndpoint()
        let pushEndpoint : String = ClientEnvironment.SharedInstance.getPushWSEndpoint()
        let myMojioEndpoint : String = ClientEnvironment.SharedInstance.getMyMojioEndpoint()
        let accountsEndpoint : String = ClientEnvironment.SharedInstance.getAccountsEndpoint()
        let region : String = ClientEnvironment.SharedInstance.getRegion()
        
        XCTAssertNotNil(apiEndpoint, "API Endpoint Pass")
        XCTAssertNotNil(apiV1Endpoint, "API V1 Endpoint Pass")
        XCTAssertNotNil(pushEndpoint, "Push Endpoint Pass")
        XCTAssertNotNil(myMojioEndpoint, "My Mojio Endpoint Pass")
        XCTAssertNotNil(accountsEndpoint, "Accounts Endpoint Pass")
        XCTAssertNotNil(region, "Region check pass")

    }
    
    func testAmericaStaging () {
        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAStaging)
        self.performLogin()
    }
    
    func testAmericaProd () {
        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAProduction)
        self.performLogin()
    }
    
    func testIsUserLoggedIn () {
        let isUserLoggedIn : Bool = self.authClient.isUserLoggedIn()
        XCTAssertNotNil(isUserLoggedIn, "Able to test if user is currently logged in")
    }        
    
    func testEuropeProd () {
        ClientEnvironment.SharedInstance.setRegion(MojioRegion.EUProduction)
        self.performLogin()
    }
    
    func testAuthController () {
        let authController : AuthViewController = AuthViewController(nibName : "AuthViewController", bundle: nil)
        // UIApplication.sharedApplication().keyWindow!.rootViewController = authController
        XCTAssertNotNil(authController, "AuthController initialized")
    }
    
    func performLogin () {
        
        let urlRequest : NSURLRequest = NSURLRequest(URL: NSURL(string: "sdkdev://io.moj#access_token=<ACCESS-TOKEN>&token_type=bearer&expires_in=43200")!)
        
        self.authClient.loginCompletion = { (authToken) in
            XCTAssert(true, "Login successful")
        }
        self.authClient.authControllerLoadURLRequest(urlRequest)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
