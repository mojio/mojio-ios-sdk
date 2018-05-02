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

class RPMTests: XCTestCase {
    
    func testRpmModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "baseUnit": "RevolutionsPerMinute",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 10,
        "unit": "RevolutionsPerMinute",
        "value": 20
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<RPM>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.baseUnit, "RevolutionsPerMinute")
        XCTAssertEqual(model?.baseValue, 10)
        XCTAssertEqual(model?.unit, "RevolutionsPerMinute")
        XCTAssertEqual(model?.value, 20)
        XCTAssertEqual(model?.timestamp, "2017-11-10T07:07:45.030Z")
    }
}
