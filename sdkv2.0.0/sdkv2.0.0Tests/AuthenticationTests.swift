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
    
    let authClient : MojioAuth = MojioAuth (clientId: "81d705ec-4025-4d96-9b30-53d2a43eaa24", clientSecretKey: "2299d863-5a3a-4aea-8bd1-0caf32a412d5", clientRedirectURI: "sdkdev://io.moj")
    
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
        MojioClientEnvironment.sharedInstance.setRegion(MojioClientRegion.NAStaging)
        self.performLogin()
    }
    
    func testAmericaProd () {
        MojioClientEnvironment.sharedInstance.setRegion(MojioClientRegion.NAProduction)
        self.performLogin()
    }
    
//    func testAmericaDevelop () {
//        MojioClientEnvironment.sharedInstance.setRegion(MojioClientRegion.nad)
//        self.performLogin()
//    }
    
    func testEuropeProd () {
        MojioClientEnvironment.sharedInstance.setRegion(MojioClientRegion.EUProduction)
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
