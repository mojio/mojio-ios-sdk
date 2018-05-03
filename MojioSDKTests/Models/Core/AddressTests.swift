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

@testable import MojioCore
import XCTest

class AddressTests: XCTestCase {
    
    var model: Address!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Address.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testAddressModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.houseNumber, "string")
        XCTAssertEqual(model?.road, "string")
        XCTAssertEqual(model?.neighbourhood, "string")
        XCTAssertEqual(model?.suburb, "string")
        XCTAssertEqual(model?.city, "string")
        XCTAssertEqual(model?.county, "string")
        XCTAssertEqual(model?.state, "string")
        XCTAssertEqual(model?.postCode, "string")
        XCTAssertEqual(model?.country, "string")
        XCTAssertEqual(model?.countryCode, "string")
        XCTAssertEqual(model?.formattedAddress, "string")
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

