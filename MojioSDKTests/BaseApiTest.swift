//
//  BaseApiTest.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-05-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
@testable import MojioSDK


class BaseApiTest: XCTestCase {
    
    let authClient : AuthClient = AuthClient(clientId: "<CLIENT_ID>", clientSecretKey: "<CLIENT_SECRET>", clientRedirectURI: "sdkdev://io.moj")
    
    override func setUp() {
        super.setUp()

        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAStaging)

        
        let expectation = self.expectationWithDescription("Login")

        self.authClient.login("Ford01", password: "Optimus123", completion: {(authToken) in
            
            KeychainManager().saveAuthToken(authToken)
            expectation.fulfill()

            }, failure: {(error) in
                // Let the tests fail
                expectation.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func runTest(testName: String, testFunction: (expectation: XCTestExpectation) -> Void){

        let expectation = self.expectationWithDescription(testName)

        testFunction(expectation: expectation);
        
        self.waitForExpectationsWithTimeout(20, handler: nil)
    }
}
