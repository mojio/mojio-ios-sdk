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

class GeofenceTests: XCTestCase {
    var model: Geofence!
    
    override func setUp() {
        super.setUp()
        
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        model = Mapper<Geofence>().map(JSONObject: jsonObject)
    }
    
    func testGeofenceShouldBeCreatedFromJsonString() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Description, "string")
        XCTAssertNotNil(model?.Region)
        XCTAssertEqual(model?.NotificationSetting, "Always")
        XCTAssertEqual(model?.VehicleIds[0], "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Tags[0], "string")
        XCTAssertEqual(model?.OwnerId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-09T07:15:14.799Z")
        XCTAssertEqual(model?.LastModified, "2017-11-09T07:15:14.799Z")
        XCTAssertEqual(model?.Deleted, true)
    }
    
    func testJsonDictShouldReturnGeofenceInfo() {
        let dict = model.jsonDict()
        
        XCTAssertEqual(dict["Id"] as? String, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(dict["Name"] as? String, "string")
        XCTAssertEqual(dict["Description"] as? String, "string")
        XCTAssertNotNil(dict["Region"] as? [String: Any])
        XCTAssertEqual(dict["NotificationSetting"] as? String, "Always")
        XCTAssertEqual(dict["Enabled"] as? Bool, true)
        XCTAssertNotNil(dict["VehicleIds"] as? [String])
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
        "Type": "string"
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
