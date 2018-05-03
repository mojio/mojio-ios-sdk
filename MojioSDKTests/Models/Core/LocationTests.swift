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

//extension DateFormatter {
//    static let iso8601Full: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter
//    }()
//}

class LocationTests: XCTestCase {
    
    var model: Location!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            let decoder = JSONDecoder()
            //decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full) //.iso8601
            self.model = try JSONDecoder().decode(Location.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testLocationModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.locationAddress)
        XCTAssertNotNil(model?.locationHeading)
        XCTAssertEqual(model?.lat, 23.0)
        XCTAssertEqual(model?.lng, 51.0)
        XCTAssertEqual(model?.status, "Unknown")
        XCTAssertEqual(model?.dilution, 30.0)
        XCTAssertEqual(model?.altitude, 35.0)
        XCTAssertEqual(model?.geoHash, "string")
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
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-09T07:16:57.388Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-09T07:16:57.388Z",
        "baseValue": 0,
        "unit": "Degree",
        "value": 0
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




