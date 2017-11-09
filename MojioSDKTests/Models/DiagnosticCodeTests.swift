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

class DiagnosticCodeTests: XCTestCase {
    func testDiagnosticCodeShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<DiagnosticCode>().map(JSONObject: jsonObject)
        let dict = model?.jsonIgnoredDict()

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Timestamp, "2017-11-09T07:16:58.072Z")
        XCTAssertEqual(model?.Code, "string")
        XCTAssertEqual(model?.Description, "string")
        XCTAssertEqual(model?.DiagnosticCodeType, "Standard")
        XCTAssertEqual(model?.StateType, "Current")
        XCTAssertEqual(model?.Severity, "Unknown")
        XCTAssertEqual(model?.Instructions, "string")
        XCTAssertEqual(model?.Ignored, true)
        
        XCTAssertEqual(dict?["Ignored"] as? Bool, true)
    }
}

extension DiagnosticCodeTests {
    var jsonString: String {
        return """
        {
        "Timestamp": "2017-11-09T07:16:58.072Z",
        "Code": "string",
        "Description": "string",
        "Type": "Standard",
        "StateType": "Current",
        "Severity": "Unknown",
        "Instructions": "string",
        "Ignored": true
        }
        """
    }
}
