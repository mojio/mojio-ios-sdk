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

class VinDetailsTests: XCTestCase {
    func testVinDetailsModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<VinDetails>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.timestamp, "2017-11-10T07:07:44.035Z")
        XCTAssertEqual(model?.Vin, "string")
        XCTAssertEqual(model?.Year, 0)
        XCTAssertEqual(model?.Make, "string")
        XCTAssertEqual(model?.Model, "string")
        XCTAssertEqual(model?.Engine, "string")
        XCTAssertEqual(model?.Cylinders, 0)
        XCTAssertNotNil(model?.TotalFuelCapacity)
        XCTAssertEqual(model?.FuelType, "string")
        XCTAssertEqual(model?.CityFuelEfficiency, 0)
        XCTAssertEqual(model?.HighwayFuelEfficiency, 0)
        XCTAssertEqual(model?.CombinedFuelEfficiency, 0)
        XCTAssertEqual(model?.Transmission, "string")
        XCTAssertEqual(model?.Message, "string")
        XCTAssertEqual(model?.Success, true)
    }
}

extension VinDetailsTests {
    var jsonString: String {
        return """
        {
        "timestamp": "2017-11-10T07:07:44.035Z",
        "Vin": "string",
        "Year": 0,
        "Make": "string",
        "Model": "string",
        "Engine": "string",
        "Cylinders": 0,
        "TotalFuelCapacity": {
        "baseUnit": "Gallons",
        "timestamp": "2017-11-10T07:07:44.035Z",
        "baseValue": 0,
        "unit": "Gallons",
        "value": 0
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
