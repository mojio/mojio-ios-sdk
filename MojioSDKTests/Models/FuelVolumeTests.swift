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

class FuelFuelVolumeTests: XCTestCase {
    func testFuelVolumeShouldBeParsedFromJsonString() {
        let jsonString = """
        {
        "BaseUnit": "Percentage",
        "Timestamp": "2017-11-09T07:16:58.072Z",
        "BaseValue": 10,
        "Unit": "Percentage",
        "Value": 20
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        
        let model = Mapper<FuelVolume>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.BaseUnit, "Percentage")
        XCTAssertEqual(model?.BaseValue, 10)
        XCTAssertEqual(model?.Unit, "Percentage")
        XCTAssertEqual(model?.Value, 20)
        XCTAssertEqual(model?.Timestamp, "2017-11-09T07:16:58.072Z")
    }
}
