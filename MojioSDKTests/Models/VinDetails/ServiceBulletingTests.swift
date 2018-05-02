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

class ServiceBulletinTests: XCTestCase {
    func testServiceBulletingModelShouldBeCreatedFromJson() {
        let jsonString = """
        {
        "ItemNumber": "string",
        "BulletinNumber": "string",
        "ReplacementBulletinNumber": "string",
        "DateAdded": "string",
        "Component": "string",
        "BulletinDate": "string",
        "Summary": "string"
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<ServiceBulletin>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.ItemNumber, "string")
        XCTAssertEqual(model?.BulletinNumber, "string")
        XCTAssertEqual(model?.ReplacementBulletinNumber, "string")
        XCTAssertEqual(model?.DateAdded, "string")
        XCTAssertEqual(model?.Component, "string")
        XCTAssertEqual(model?.BulletinDate, "string")
        XCTAssertEqual(model?.Summary, "string")
    }
}
