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

class VinDetailsTests: XCTestCase {
    
    var model: VinDetails!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(VinDetails.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testVinDetailsModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.vin, "string")
        XCTAssertEqual(model?.year, 0)
        XCTAssertEqual(model?.make, "string")
        XCTAssertEqual(model?.model, "string")
        XCTAssertEqual(model?.engine, "string")
        XCTAssertEqual(model?.cylinders, 0)
        XCTAssertNotNil(model?.totalFuelCapacity)
        XCTAssertEqual(model?.fuelType, "string")
        XCTAssertEqual(model?.cityFuelEfficiency, 0)
        XCTAssertEqual(model?.highwayFuelEfficiency, 0)
        XCTAssertEqual(model?.combinedFuelEfficiency, 0)
        XCTAssertEqual(model?.transmission, "string")
        XCTAssertEqual(model?.message, "string")
        XCTAssertEqual(model?.success, true)
    }
}

extension VinDetailsTests {
    var jsonString: String {
        return """
        {
        "Timestamp": "2017-11-10T07:07:44.035Z",
        "Vin": "string",
        "Year": 0,
        "Make": "string",
        "Model": "string",
        "Engine": "string",
        "Cylinders": 0,
        "TotalFuelCapacity": {
        "BaseUnit": "Gallons",
        "Timestamp": "2017-11-10T07:07:44.035Z",
        "BaseValue": 0,
        "Unit": "Gallons",
        "Value": 0
        },
        "FuelType": "string",
        "CityFuelEfficiency": 0,
        "HighwayFuelEfficiency": 0,
        "CombinedFuelEfficiency": 0,
        "Transmission": "string",
        "Message": "string",
        "Success": true
        }
        """
    }
}













