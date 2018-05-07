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

class WarrantyTests: XCTestCase {
    
    var model: Warranty!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Warranty.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testWarrantyModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "string")
        XCTAssertEqual(model?.type, "string")
        XCTAssertEqual(model?.months, "string")
        XCTAssertEqual(model?.km, 0)
    }
}

extension WarrantyTests {
    var jsonString: String {
        return """
        {
        "Name": "string",
        "Type": "string",
        "Months": "string",
        "Km": 0
        }
        """
    }
}













