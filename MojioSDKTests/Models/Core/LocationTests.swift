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

class LocationTests: XCTestCase {
    
    var model: Location!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Location.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testLocationModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testLocationModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Location.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Location?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.locationAddress)
            XCTAssertNotNil(model.locationHeading)
            XCTAssertEqual(model.lat, 23.0)
            XCTAssertEqual(model.lng, 51.0)
            XCTAssertEqual(model.status, "Unknown")
            XCTAssertEqual(model.dilution, 30.0)
            XCTAssertEqual(model.altitude, 35.0)
            XCTAssertEqual(model.geoHash, "string")
        }
    }
}

extension LocationTests {
    var jsonString: String {
        return """
        {
            "Timestamp": "2017-11-09T07:16:57.388Z",
            "Lat": 23.0,
            "Lng": 51.0,
            "Status": "Unknown",
            "Dilution": 30.0,
            "Altitude": 35.0,
            "GeoHash": "string",
            "Radius": 15,
            "Heading": {
                "BaseUnit": "Degree",
                "Direction": "string",
                "LeftTurn": true,
                "Timestamp": "2017-11-09T07:16:57.388Z",
                "BaseValue": 0,
                "Unit": "Degree",
                "Value": 0
            },
            "Address": {
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
        }
        """
    }
}




