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

class AddressTests: XCTestCase {
    func testAddressShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Address>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.HouseNumber, "string")
        XCTAssertEqual(model?.Road, "string")
        XCTAssertEqual(model?.Neighbourhood, "string")
        XCTAssertEqual(model?.Suburb, "string")
        XCTAssertEqual(model?.City, "string")
        XCTAssertEqual(model?.County, "string")
        XCTAssertEqual(model?.State, "string")
        XCTAssertEqual(model?.PostCode, "string")
        XCTAssertEqual(model?.Country, "string")
        XCTAssertEqual(model?.CountryCode, "string")
        XCTAssertEqual(model?.FormattedAddress, "string")
    }
}

extension AddressTests {
    var jsonString: String {
        return """
        {
        "HouseNumber": "string",
        "Road": "string",
        "Neighbourhood": "string",
        "Suburb": "string",
        "City": "string",
        "County": "string",
        "State": "string",
        "PostCode": "string",
        "Country": "string",
        "CountryCode": "string",
        "FormattedAddress": "string"
        }
        """
    }
}
