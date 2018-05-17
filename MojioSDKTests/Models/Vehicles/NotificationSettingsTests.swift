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

class NotificationsSettingsTests: XCTestCase {
    
    var model: NotificationsSettings!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(NotificationsSettings.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testNotificationsSettingsModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testNotificationsSettingsModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(NotificationsSettings.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: NotificationsSettings?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.disturbanceThreshold, .high)
            XCTAssertEqual(model.enableTripStartActivity, true)
            XCTAssertEqual(model.enableGeofenceActivity, true)
            XCTAssertEqual(model.enableTripCompletedActivity, true)
            XCTAssertEqual(model.enableLowFuelActivity, true)
            XCTAssertEqual(model.enableLowBatteryActivity, true)
            XCTAssertEqual(model.enableSpeedActivity, true)
            XCTAssertNotNil(model.speedThreshold)
            XCTAssertEqual(model.speedThreshold?.baseUnit, .kilometersPerHour)
            XCTAssertEqual(model.enableDtcActivity, true)
            XCTAssertEqual(model.enableCheckEngineActivity, true)
            XCTAssertEqual(model.enableTowActivity, true)
            XCTAssertEqual(model.enableMaintenanceActivity, true)
            XCTAssertEqual(model.enableRecallActivity, true)
            XCTAssertEqual(model.enableServiceBulletinActivity, true)
            XCTAssertEqual(model.enableDisturbanceActivity, true)
            XCTAssertEqual(model.enableAccidentActivity, true)
            XCTAssertEqual(model.enableDeviceUnpluggedActivity, true)
            XCTAssertEqual(model.enableVehicleConnectedActivity, true)
            XCTAssertEqual(model.enableDeviceUpdatedActivity, true)
            XCTAssertEqual(model.enableSMSActivity, true)
            XCTAssertEqual(model.enableVehicleCompatibilityActivity, true)
        }
    }
}

extension NotificationsSettingsTests {
    var jsonString: String {
        return """
        {
            "EnableTripStartActivity": true,
            "EnableTripCompletedActivity": true,
            "EnableLowFuelActivity": true,
            "EnableLowBatteryActivity": true,
            "EnableSpeedActivity": true,
            "EnableGeofenceActivity": true,
            "SpeedThreshold": {
                "BaseUnit": "KilometersPerHour",
                "Timestamp": "2017-11-10T07:07:44.892Z",
                "BaseValue": 0,
                "Unit": "KilometersPerHour",
                "Value": 0
            },
            "DisturbanceThreshold": "High",
            "EnableDtcActivity": true,
            "EnableCheckEngineActivity": true,
            "EnableTowActivity": true,
            "EnableMaintenanceActivity": true,
            "EnableRecallActivity": true,
            "EnableServiceBulletinActivity": true,
            "EnableDisturbanceActivity": true,
            "EnableAccidentActivity": true,
            "EnableDeviceUnpluggedActivity": true,
            "EnableVehicleConnectedActivity": true,
            "EnableDeviceUpdatedActivity": true,
            "EnableSMSActivity": true,
            "EnableVehicleCompatibilityActivity": true
        }
        """
    }
}

