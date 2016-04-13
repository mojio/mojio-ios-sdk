//
//  sdkv2_0_0UITests.swift
//  sdkv2.0.0UITests
//
//  Created by Ashish Agarwal on 2016-03-02.
//  Copyright © 2016 Mojio. All rights reserved.
//

import XCTest

class sdkv2_0_0UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLogin () {        
        let app = XCUIApplication()
        app.otherElements["Login to Mojio"].childrenMatchingType(.Link).elementBoundByIndex(0).childrenMatchingType(.Button).element.tap()
        
        let loginToMojioAccountElement = app.otherElements["Login to Mojio account"]
        let textField = loginToMojioAccountElement.childrenMatchingType(.TextField).element
        textField.tap()
        loginToMojioAccountElement.childrenMatchingType(.TextField).element
        app.typeText("ashisha@moj.io")

        let secureTextField = loginToMojioAccountElement.childrenMatchingType(.SecureTextField).element
        secureTextField.tap()
        textField.tap()
        secureTextField.tap()
        loginToMojioAccountElement.childrenMatchingType(.SecureTextField).element
        app.typeText("Test123\r")
        
    }
    
}
