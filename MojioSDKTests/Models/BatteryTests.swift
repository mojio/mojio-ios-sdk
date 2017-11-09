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

@testable import MojioSDK
import ObjectMapper
import XCTest

class BatteryTests: XCTestCase {
    func testBatteryModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Battery>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Connected, true)
        XCTAssertEqual(model?.RiskSeverity, "Unknown")
        XCTAssertNotNil(model?.LowVoltageDuration)
        XCTAssertNotNil(model?.HighVoltageDuration)
        XCTAssertEqual(model?.BaseUnit, "MilliVolts")
        XCTAssertEqual(model?.Unit, "MilliVolts")
        XCTAssertEqual(model?.BaseValue, 10)
        XCTAssertEqual(model?.Value, 20)
        XCTAssertEqual(model?.Timestamp, "2017-11-09T07:16:58.073Z")
    }
}

extension BatteryTests {
    var jsonString: String {
        return """
        {
            "Connected": true,
            "RiskSeverity": "Unknown",
            "LowVoltageDuration": {
                "BaseUnit": "Ticks",
                "Timestamp": "2017-11-09T07:16:58.073Z",
                "BaseValue": 0,
                "Unit": "Ticks",
                "Value": 0
            },
            "HighVoltageDuration": {
                "BaseUnit": "Ticks",
                "Timestamp": "2017-11-09T07:16:58.073Z",
                "BaseValue": 0,
                "Unit": "Ticks",
                "Value": 0
            },
            "BaseUnit": "MilliVolts",
            "Timestamp": "2017-11-09T07:16:58.073Z",
            "BaseValue": 10,
            "Unit": "MilliVolts",
            "Value": 20
        }
        """
    }
}
