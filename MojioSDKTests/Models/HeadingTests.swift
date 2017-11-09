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

class HeadingTests: XCTestCase {
    func testHeadingModelShouldBeParsedFromJson() {
        let jsonString = """
        {
        "BaseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "Timestamp": "2017-11-09T07:15:16.084Z",
        "BaseValue": 10,
        "Unit": "Degree",
        "Value": 20
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Heading>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Direction, "string")
        XCTAssertEqual(model?.LeftTurn, true)
        XCTAssertEqual(model?.BaseUnit, "Degree")
        XCTAssertEqual(model?.Unit, "Degree")
        XCTAssertEqual(model?.BaseValue, 10)
        XCTAssertEqual(model?.Value, 20)
        XCTAssertEqual(model?.Timestamp, "2017-11-09T07:15:16.084Z")
        XCTAssertEqual(model?.baseHeadingUnit, .degree)
        XCTAssertEqual(model?.headingUnit, .degree)
    }
}
