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
import XCTest
import ObjectMapper

class AccelerationTests: XCTestCase {
    func testDeviceMeasurementModelShouldBeParsedFromJson() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Acceleration>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.BaseUnit, "")
        XCTAssertEqual(model?.BaseValue, 100)
        XCTAssertEqual(model?.Unit, "")
        XCTAssertEqual(model?.Value, 120)
        XCTAssertEqual(model?.Timestamp, "")
    }
}

extension AccelerationTests {
    var jsonString: String {
        return """
        {
        "BaseUnit": "",
        "BaseValue": 100,
        "Unit": "",
        "Value": 120,
        "Timestamp": ""
        }
        """
    }
}
