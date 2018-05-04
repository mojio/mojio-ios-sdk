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

class OdometerTests: XCTestCase {
    
    var model: Odometer!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Odometer.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testOdometerModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.rolloverValue, 10)
        XCTAssertEqual(model?.baseUnit, "Meters")
        XCTAssertEqual(model?.baseValue, 20)
        XCTAssertEqual(model?.unit, "Meters")
        XCTAssertEqual(model?.value, 30)
    }
}

extension OdometerTests {
    var jsonString: String {
        return """
        {
        "RolloverValue": 10,
        "BaseUnit": "Meters",
        "Timestamp": "2017-11-10T07:07:45.030Z",
        "BaseValue": 20,
        "Unit": "Meters",
        "Value": 30
        }
        """
    }
}




