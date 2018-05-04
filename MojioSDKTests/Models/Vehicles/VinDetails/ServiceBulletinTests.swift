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

@testable import Vehicles
import XCTest

class ServiceBulletinTests: XCTestCase {
    
    var model: ServiceBulletin!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(ServiceBulletin.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testServiceBulletinModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.itemNumber, "string")
        XCTAssertEqual(model?.bulletinNumber, "string")
        XCTAssertEqual(model?.replacementBulletinNumber, "string")
        XCTAssertEqual(model?.component, "string")
        XCTAssertEqual(model?.summary, "string")
    }
}

extension ServiceBulletinTests {
    var jsonString: String {
        return """
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
    }
}






