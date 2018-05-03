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

@testable import Vehicles //MojioSDK
import XCTest

class AccelerometerTests: XCTestCase {
    func testAccelerometerShouldBeCreatedFromJsonString() {
//        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
//        let model = Mapper<Accelerometer>().map(JSONObject: jsonObject)
//
//        XCTAssertNotNil(model)
//        XCTAssertNotNil(model?.X)
//        XCTAssertNotNil(model?.Y)
//        XCTAssertNotNil(model?.Z)
//        XCTAssertNotNil(model?.Magnitude)
//        XCTAssertNotNil(model?.SamplingInterval)
    }
}

extension AccelerometerTests {
    var jsonString: String {
        return """
        {
        "X": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-09T07:16:58.072Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Y": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-09T07:16:58.072Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Z": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-09T07:16:58.072Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Magnitude": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-09T07:16:58.072Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "SamplingInterval": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-09T07:16:58.072Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        }
        }
        """
    }
}
