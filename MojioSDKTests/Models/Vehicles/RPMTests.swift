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

@testable import Vehicles
import XCTest

class RPMTests: XCTestCase {
    
    var model: RPM!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(RPM.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testRPMModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testRPMModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(RPM.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: RPM?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.baseUnit, .revolutionsPerMinute)
            XCTAssertEqual(model.baseValue, 10)
            XCTAssertEqual(model.unit, .unknown)
            XCTAssertEqual(model.value, 20)
        }
    }
}

extension RPMTests {
    var jsonString: String {
        return """
        {
            "BaseUnit": "RevolutionsPerMinute",
            "Timestamp": "2017-11-10T07:07:45.030Z",
            "BaseValue": 10,
            "Unit": "RevolutionsPer",
            "Value": 20
        }
        """
    }
}





