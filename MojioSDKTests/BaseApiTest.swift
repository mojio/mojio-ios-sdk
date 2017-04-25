/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import XCTest
@testable import MojioSDK


class BaseApiTest: XCTestCase {
    
    let authClient : AuthClient = AuthClient(clientId: "81d705ec-4025-4d96-9b30-53d2a43eaa24", clientSecretKey: "2299d863-5a3a-4aea-8bd1-0caf32a412d5", clientRedirectURI: "sdkdev://io.moj")
    
    override func setUp() {
        super.setUp()

        ClientEnvironment.SharedInstance.setRegion(MojioRegion.NAStaging)

        
        let expectation = self.expectation(description: "Login")

        self.authClient.login("Ford01", password: "Optimus123", completion: {(authToken) in
            
            KeychainManager().saveAuthToken(authToken)
            expectation.fulfill()

            }, failure: {(error) in
                // Let the tests fail
                expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func runTest(_ testName: String, testFunction: (_ expectation: XCTestExpectation) -> Void){

        let expectation = self.expectation(description: testName)

        testFunction(expectation);
        
        self.waitForExpectations(timeout: 20, handler: nil)
    }
}
