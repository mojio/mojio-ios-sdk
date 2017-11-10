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

class OdometerTests: XCTestCase {
    func testOdometerModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "RolloverValue": 10,
        "BaseUnit": "Meters",
        "Timestamp": "2017-11-10T07:07:45.030Z",
        "BaseValue": 20,
        "Unit": "Meters",
        "Value": 30
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Odometer>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.RolloverValue, 10)
        XCTAssertEqual(model?.BaseUnit, "Meters")
        XCTAssertEqual(model?.Timestamp, "2017-11-10T07:07:45.030Z")
        XCTAssertEqual(model?.BaseValue, 20)
        XCTAssertEqual(model?.Unit, "Meters")
        XCTAssertEqual(model?.Value, 30)
    }
}
