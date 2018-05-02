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

class WarrantyTests: XCTestCase {
    func testWarrantyModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "Name": "string",
        "Type": "string",
        "Months": "string",
        "Km": 0
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Warranty>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Type, "string")
        XCTAssertEqual(model?.Months, "string")
        XCTAssertEqual(model?.Km, 0)
    }
}
