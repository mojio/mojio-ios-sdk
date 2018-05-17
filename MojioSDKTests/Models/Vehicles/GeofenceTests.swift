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
        helperMethod(_model: model)
    }
    
    func testGeofenceModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Geofence.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Geofence?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.name, "string")
            XCTAssertEqual(model.description, "string")
            XCTAssertNotNil(model.region)
            XCTAssertEqual(model.region?.type, .unknown)
            XCTAssertEqual(model.notificationSetting, .always)
            XCTAssertEqual(model.vehicleIds[0], "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.tags[0], "string")
            XCTAssertEqual(model.ownerId, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.id, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.deleted, true)
        }
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
                "Type": "Square"
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
            "Deleted": true
        }
        """
    }
}






