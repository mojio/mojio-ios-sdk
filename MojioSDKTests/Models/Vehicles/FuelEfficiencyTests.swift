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

class FuelEfficiencyTests: XCTestCase {
    
    var model: FuelEfficiency!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(FuelEfficiency.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testFuelEfficiencyModelDecoding() {
        self.helperMethod(_model: model)
    }
    
    func testFuelEfficiencyModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(FuelEfficiency.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: FuelEfficiency?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.baseUnit, .kilometerPerLiter)
            XCTAssertEqual(model.baseValue, 10)
            XCTAssertEqual(model.unit, .unknown)
            XCTAssertEqual(model.value, 20)
        }
    }
}

extension FuelEfficiencyTests {
    var jsonString: String {
        return """
        {
            "BaseUnit": "KilometerPerLiter",
            "BaseValue": 10,
            "Unit": "MetersPerSecondPerSecond",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
        }
        """
    }
}






