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

class IdleStateTests: XCTestCase {
    
    var model: IdleState!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(IdleState.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testIdleStateModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testIdleStateModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(IdleState.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: IdleState?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.value, true)
            XCTAssertEqual(model.startTime, "2017-11-09T07:15:16.084Z")
            XCTAssertNotNil(model.duration)
        }
    }
}

extension IdleStateTests {
    var jsonString: String {
        return """
        {
            "Timestamp": "2017-11-09T07:15:16.084Z",
            "Value": true,
            "StartTime": "2017-11-09T07:15:16.084Z",
            "Duration": {
                "BaseUnit": "Ticks",
                "Timestamp": "2017-11-09T07:15:16.084Z",
                "BaseValue": 0,
                "Unit": "Ticks",
                "Value": 0
            }
        }
        
        """
    }
}


