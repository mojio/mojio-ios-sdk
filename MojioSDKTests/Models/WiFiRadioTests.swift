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

class WiFiRadioTests: XCTestCase {
    func testWiFiRadioModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "Timestamp": "2017-11-10T07:07:42.736Z",
        "SSID": "string",
        "Password": "string",
        "AllowRoaming": true,
        "Status": "Unknown",
        "Strength": 0
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<WifiRadio>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Timestamp, "2017-11-10T07:07:42.736Z")
        XCTAssertEqual(model?.SSID, "string")
        XCTAssertEqual(model?.Password, "string")
        XCTAssertEqual(model?.AllowRoaming, true)
        XCTAssertEqual(model?.Status, "Unknown")
        XCTAssertEqual(model?.Strength, 0)
    }
}
