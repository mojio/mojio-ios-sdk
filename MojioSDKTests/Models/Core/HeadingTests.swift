/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

@testable import MojioCore
import XCTest

class HeadingTests: XCTestCase {
    
    var model: Heading!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Heading.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testHeadingModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testHeadingModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Heading.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Heading?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.direction, "string")
            XCTAssertEqual(model.leftTurn, true)
            XCTAssertEqual(model.baseUnit, .degree)
            XCTAssertEqual(model.unit, .unknown)
            XCTAssertEqual(model.baseValue, 10)
            XCTAssertEqual(model.value, 20)
        }
    }
}

extension HeadingTests {
    var jsonString: String {
        return """
        {
            "BaseUnit": "Degree",
            "Direction": "string",
            "LeftTurn": true,
            "Timestamp": "2017-11-09T07:15:16.084Z",
            "BaseValue": 10,
            "Unit": "Degr",
            "Value": 20
        }
        """
    }
}



