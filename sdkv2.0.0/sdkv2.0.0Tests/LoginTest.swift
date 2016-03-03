//
//  LoginTest.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
@testable import sdkv2_0_0

class LoginTest: XCTestCase {
    
    let authClient : MojioAuth = MojioAuth(appId: "81d705ec-4025-4d96-9b30-53d2a43eaa24", redirectURI: "sdkdev://")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.authClient.logout()
        MojioClientEnvironment.clientEnvironment.setEnvironment(Environment.AMERICA_STAGING)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnvironments () {
        
    }
    
    func testLogin() {
        
        self.authClient.login({
            XCTAssert(true, "Login successful")
        })
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
