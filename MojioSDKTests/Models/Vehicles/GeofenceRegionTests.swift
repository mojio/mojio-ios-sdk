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

class GeofenceRegionTests: XCTestCase {
    
    var model: GeofenceRegion!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(GeofenceRegion.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testGeofenceRegionModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testGeofenceRegionModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(GeofenceRegion.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: GeofenceRegion?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.type, .circle)
            XCTAssertEqual(model.radius?.baseUnit, .meters)
            XCTAssertEqual(model.latitude, 24.1)
            XCTAssertEqual(model.longitude, 51.2)
            XCTAssertNotNil(model.radius)
        }
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







