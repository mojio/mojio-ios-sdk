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

class AggregationDataTests: XCTestCase {
    func testAggregationDataShouldBeCreatedFromJson() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<AggregationData>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Total, 12)
        XCTAssertEqual(model?.Average, 15)
        XCTAssertEqual(model?.Max, 21)
        XCTAssertEqual(model?.Min, 1)
        XCTAssertEqual(model?.units, "MetersPerSecondPerSecond")
        XCTAssertEqual(model?.Date, "2017-11-09T07:16:58.072Z")
        XCTAssertEqual(model?.EndDate, "2017-11-09T07:16:58.072Z")
        XCTAssertEqual(model?.Count, 31)
        XCTAssertEqual(model?.TripCount, 5)
    }
}

extension AggregationDataTests {
    var jsonString: String {
        return """
        {
        "Total": 12,
        "Average": 15,
        "Max": 21,
        "Min": 1,
        "Units": "MetersPerSecondPerSecond",
        "Date": "2017-11-09T07:16:58.072Z",
        "EndDate": "2017-11-09T07:16:58.072Z",
        "Count": 31,
        "TripCount": 5
        }
        """
    }
}
