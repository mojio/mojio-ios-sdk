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

class GeofenceTests: XCTestCase {
    
    var model: Geofence!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Geofence.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testGeofenceModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Description, "string")
        XCTAssertNotNil(model?.Region)
        XCTAssertEqual(model?.NotificationSetting, .always)
        XCTAssertEqual(model?.VehicleIds[0], "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Tags[0], "string")
        XCTAssertEqual(model?.OwnerId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-09T07:15:14.799Z")
        XCTAssertEqual(model?.LastModified, "2017-11-09T07:15:14.799Z")
        XCTAssertEqual(model?.Deleted, true)
    }
}

extension GeofenceTests {
    var jsonString: String {
        return """
        {
        "Name": "string",
        "Description": "string",
        "Enabled": true,
        "Region": {
        "Type": "Circle"
        },
        "NotificationSetting": "Always",
        "VehicleIds": [
        "00000000-0000-0000-0000-000000000000"
        ],
        "Tags": [
        "string"
        ],
        "OwnerId": "00000000-0000-0000-0000-000000000000",
        "Id": "00000000-0000-0000-0000-000000000000",
        "CreatedOn": "2017-11-09T07:15:14.799Z",
        "LastModified": "2017-11-09T07:15:14.799Z",
        "Deleted": true,
        "Metadata": {},
        "Links": {}
        }
        """
    }
}






