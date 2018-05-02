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

class ActivityLocationTests: XCTestCase {
    func testActivityLocationModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<ActivityLocation>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.ActivityType, "Location")
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Latitude, 0)
        XCTAssertEqual(model?.Longitude, 0)
        XCTAssertEqual(model?.Altitude, 0)
        XCTAssertEqual(model?.Radius, 0)
    }
    
    func testActivityLocationShouldReturnLocation() {
        var activity = ActivityLocation()
        activity.Latitude = 10
        activity.Longitude = 20
        activity.Radius = 30
        activity.Altitude = 40
        activity.Name = "string"
        
        let location = activity.toLocation()
        
        XCTAssertEqual(location.Lat, activity.Latitude)
        XCTAssertEqual(location.Lng, activity.Longitude)
        XCTAssertEqual(location.Radius, activity.Radius)
        XCTAssertEqual(location.Altitude, activity.Altitude)
        XCTAssertEqual(location.LocationAddress?.FormattedAddress, activity.Name)
    }
}

extension ActivityLocationTests {
    var jsonString: String {
        return """
        {
        "Longitude": 0,
        "Latitude": 0,
        "Altitude": 0,
        "Radius": 0,
        "Name": "string",
        "Type": "Location"
        }
        """
    }
}
