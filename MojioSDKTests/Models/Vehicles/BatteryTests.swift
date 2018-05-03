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

class BatteryTests: XCTestCase {
    
    var model: Battery!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Battery.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testBatteryModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Connected, true)
        XCTAssertEqual(model?.RiskSeverity, "Unknown")
        XCTAssertNotNil(model?.LowVoltageDuration)
        XCTAssertNotNil(model?.HighVoltageDuration)
        XCTAssertEqual(model?.baseUnit, "MilliVolts")
        XCTAssertEqual(model?.unit, "MilliVolts")
        XCTAssertEqual(model?.baseValue, 10)
        XCTAssertEqual(model?.value, 20)
    }
}

extension BatteryTests {
    var jsonString: String {
        return """
        {
        "Connected": true,
        "RiskSeverity": "Unknown",
        "LowVoltageDuration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-09T07:16:58.073Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        },
        "HighVoltageDuration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-09T07:16:58.073Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        },
        "baseUnit": "MilliVolts",
        "timestamp": "2017-11-09T07:16:58.073Z",
        "baseValue": 10,
        "unit": "MilliVolts",
        "value": 20
        }
        """
    }
}
