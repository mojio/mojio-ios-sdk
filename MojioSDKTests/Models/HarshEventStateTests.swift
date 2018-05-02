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

class HarshEventStateTests: XCTestCase {
    
    func testHarshEvenStateModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "timestamp": "2017-11-09T07:15:16.084Z",
        "value": true,
        "EventType": "Acceleration",
        "TurnType": "Left"
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<HarshEventState>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.timestamp, "2017-11-09T07:15:16.084Z")
        XCTAssertEqual(model?.value, true)
        XCTAssertEqual(model?.EventType, "Acceleration")
        XCTAssertEqual(model?.TurnType, "Left")
    }
}
