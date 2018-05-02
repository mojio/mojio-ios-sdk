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

class NotificationsSettingsTests: XCTestCase {
    func testNotificationSettingsModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<NotificationsSettings>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.EnableTripStartActivity, true)
        XCTAssertEqual(model?.EnableTripCompletedActivity, true)
        XCTAssertEqual(model?.EnableLowFuelActivity, true)
        XCTAssertEqual(model?.EnableLowBatteryActivity, true)
        XCTAssertEqual(model?.EnableSpeedActivity, true)
        XCTAssertNotNil(model?.SpeedThreshold)
        XCTAssertEqual(model?.EnableDtcActivity, true)
        XCTAssertEqual(model?.EnableCheckEngineActivity, true)
        XCTAssertEqual(model?.EnableTowActivity, true)
        XCTAssertEqual(model?.EnableMaintenanceActivity, true)
        XCTAssertEqual(model?.EnableRecallActivity, true)
        XCTAssertEqual(model?.EnableServiceBulletinActivity, true)
        XCTAssertEqual(model?.EnableDisturbanceActivity, true)
        XCTAssertEqual(model?.EnableAccidentActivity, true)
        XCTAssertEqual(model?.EnableDeviceUnpluggedActivity, true)
        XCTAssertEqual(model?.EnableVehicleConnectedActivity, true)
        XCTAssertEqual(model?.EnableDeviceUpdatedActivity, true)
        XCTAssertEqual(model?.EnableSMSActivity, true)
        XCTAssertEqual(model?.EnableVehicleCompatibilityActivity, true)
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
            "SpeedThreshold": {
                "baseUnit": "KilometersPerHour",
                "timestamp": "2017-11-10T07:07:44.892Z",
                "baseValue": 0,
                "unit": "KilometersPerHour",
                "value": 0
            },
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
