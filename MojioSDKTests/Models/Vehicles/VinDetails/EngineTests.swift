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

@testable import Vehicles
import XCTest

class EngineTests: XCTestCase {
    
    var model: Engine!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Engine.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testEngineModelDecoding() {
        self.helperMethod(_model: model)
    }
    
    func testEngineModelEncoding() {
        do {
            let encoder = JSONEncoder()
            
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Engine.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Engine?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.name, "string")
            XCTAssertEqual(model.cylinders, "string")
            XCTAssertEqual(model.displacement, 0)
            XCTAssertEqual(model.fuelInduction, "string")
            XCTAssertEqual(model.fuelQuality, "string")
            XCTAssertEqual(model.fuelType, "string")
            XCTAssertEqual(model.maxHp, "string")
            XCTAssertEqual(model.maxHpAt, "string")
        }
    }
}

extension EngineTests {
    var jsonString: String {
        return """
        {
            "Name": "string",
            "Cylinders": "string",
            "Displacement": 0,
            "FuelInduction": "string",
            "FuelQuality": "string",
            "FuelType": "string",
            "MaxHp": "string",
            "MaxHpAt": "string"
        }
        """
    }
}


