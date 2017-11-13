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

class BaseActivityLocationTests: XCTestCase {
    func testBaseActivityLocationShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "Id": "string",
        "Type": "string",
        "Href": "string",
        "Name": "string"
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<TestableBaseActivityLocation>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Id, "string")
        XCTAssertEqual(model?.ActivityType, "string")
        XCTAssertEqual(model?.Href, "string")
        XCTAssertEqual(model?.Name, "string")
    }
    
    class TestableBaseActivityLocation: BaseActivityLocation {
        var Id: String? = nil
        var ActivityType: String? = nil
        var Href: String? = nil
        var Name: String? = nil
        var NameMap: Dictionary<String, String>? = nil

        public init() {}
        
        required convenience init?(map: Map) {
            self.init()
        }
    }
}
