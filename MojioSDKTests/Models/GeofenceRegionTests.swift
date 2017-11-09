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
import ObjectMapper
import XCTest

class GeofenceRegionTests: XCTestCase {
    var model: GeofenceRegion!
    
    override func setUp() {
        super.setUp()
        
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        model = Mapper<GeofenceRegion>().map(JSONObject: jsonObject)
    }
    
    func testGeofenceRegionShouldBeCreatedFromJsonString() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.GeofenceType, "Circle")
        XCTAssertEqual(model?.Lat, 24.1)
        XCTAssertEqual(model?.Lng, 51.2)
        XCTAssertNotNil(model?.Radius)
    }
    
    func testJsonDictShouldReturnGeofenceInfo() {
        let dict = model.jsonDict()
        
        XCTAssertEqual(dict["Type"] as? String, "Circle")
        XCTAssertEqual(dict["Lat"] as? Double, 24.1)
        XCTAssertEqual(dict["Lng"] as? Double, 51.2)
        XCTAssertNotNil(dict["Radius"])
    }
}

extension GeofenceRegionTests {
    var jsonString: String {
        return """
        {
            "Type": "Circle",
            "Lat": 24.1,
            "Lng": 51.2,
            "Radius": {
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-09T07:16:57.840Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            }
        }
        """
    }
}
