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

class FuelVolumeTests: XCTestCase {
    
    var model: FuelVolume!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(FuelVolume.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testFuelVolumeModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.baseUnit, "Percentage")
        XCTAssertEqual(model?.baseValue, 10)
        XCTAssertEqual(model?.unit, "Percentage")
        XCTAssertEqual(model?.value, 20)
    }
}

extension FuelVolumeTests {
    var jsonString: String {
        return """
        {
        "BaseUnit": "Percentage",
        "Timestamp": "2017-11-09T07:16:58.072Z",
        "BaseValue": 10,
        "Unit": "Percentage",
        "Value": 20
        }
        """
    }
}





