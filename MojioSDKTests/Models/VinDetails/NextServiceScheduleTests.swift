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

class NextServiceScheduleTests: XCTestCase {

    func testNextServiceScheduleModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "VIN": "string",
        "TimeStamp": "2017-11-10T07:07:45.398Z",
        "Odometer": 0,
        "AgeInMonths": 0,
        "TimeUnits": "string",
        "TimeValue": 0,
        "DistanceUnits": "string",
        "DistanceValue": 0,
        "Items": [{
        "TransNotes": "string",
        "ScheduleName": "string",
        "ScheduleDescription": "string",
        "MaintenanceCategory": "string",
        "MaintenanceName": "string",
        "MaintenanceNotes": "string"
        }]}
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<NextServiceSchedule>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.TimeStamp, "2017-11-10T07:07:45.398Z")
        XCTAssertEqual(model?.Odometer, 0)
        XCTAssertEqual(model?.AgeInMonths, 0)
        XCTAssertEqual(model?.TimeUnits, "string")
        XCTAssertEqual(model?.TimeValue, 0)
        XCTAssertEqual(model?.DistanceUnits, "string")
        XCTAssertEqual(model?.DistanceValue, 0)
        XCTAssertNotNil(model?.Services)
    }
}
