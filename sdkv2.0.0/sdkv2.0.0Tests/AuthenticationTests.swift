//
//  LoginTest.swift
//  sdkv2.0.0
//
//  Created by Ashish Agarwal on 2016-02-29.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest
@testable import sdkv2_0_0

class AuthenticationTests: XCTestCase {
    
    let authClient : MojioAuth = MojioAuth(appId: "81d705ec-4025-4d96-9b30-53d2a43eaa24", redirectURI: "sdkdev://")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.authClient.logout()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAmericaStaging () {
        MojioClientEnvironment.clientEnvironment.setEnvironment(Environment.AMERICA_STAGING)
        self.performLogin()
    }
    
    func testAmericaProd () {
        MojioClientEnvironment.clientEnvironment.setEnvironment(Environment.AMERICA_PRODUCTION)
        self.performLogin()
    }
    
    func testAmericaDevelop () {
        MojioClientEnvironment.clientEnvironment.setEnvironment(Environment.AMERICA_DEVELOP)
        self.performLogin()
    }
    
    func testEuropeProd () {
        MojioClientEnvironment.clientEnvironment.setEnvironment(Environment.EU_PRODUCTION)
        self.performLogin()
    }
    
    func performLogin () {
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
