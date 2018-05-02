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

class EngineTests: XCTestCase {
    func testEngineModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "Name": "string",
        "Cylinders": "string",
        "Displacement": "string",
        "FuelInduction": "string",
        "FuelQuality": "string",
        "FuelType": "string",
        "MaxHp": "string",
        "MaxHpAt": "string"
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Engine>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Cylinders, "string")
        XCTAssertEqual(model?.Displacement, 0)
        XCTAssertEqual(model?.FuelInduction, "string")
        XCTAssertEqual(model?.FuelQuality, "string")
        XCTAssertEqual(model?.FuelType, "string")
        XCTAssertEqual(model?.MaxHp, "string")
        XCTAssertEqual(model?.MaxHpAt, "string")
    }
}
