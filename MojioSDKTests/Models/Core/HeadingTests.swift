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

class HeadingTests: XCTestCase {
    
    var model: Heading!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Heading.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testHeadingModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Direction, "string")
        XCTAssertEqual(model?.LeftTurn, true)
        XCTAssertEqual(model?.baseUnit, "Degree")
        XCTAssertEqual(model?.unit, "Degree")
        XCTAssertEqual(model?.baseValue, 10)
        XCTAssertEqual(model?.value, 20)
        XCTAssertEqual(model?.baseHeadingUnit, .degree)
        XCTAssertEqual(model?.headingUnit, .degree)
    }
}

extension HeadingTests {
    var jsonString: String {
        return """
        {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-09T07:15:16.084Z",
        "baseValue": 10,
        "unit": "Degree",
        "value": 20
        
        }
        """
    }
}



