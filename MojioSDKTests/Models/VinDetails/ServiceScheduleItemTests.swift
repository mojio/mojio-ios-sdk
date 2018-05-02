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

class ServiceScheduleItemTests: XCTestCase {
    func testServiceScheduleItemModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "TransNotes": "string",
        "ScheduleName": "string",
        "ScheduleDescription": "string",
        "MaintenanceCategory": "string",
        "MaintenanceName": "string",
        "MaintenanceNotes": "string",
        "Intervals": [{
        "OperatingParameter": "string",
        "OperatingParameterNotes": "string",
        "IntervalType": "string",
        "value": 0,
        "Units": "string",
        "InitialValue": 0
        }],
        "Events": [{
        "ComputerCode": "string",
        "Event": "string"
        }]}
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<ServiceScheduleItem>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.TransNotes, "string")
        XCTAssertEqual(model?.ScheduleName, "string")
        XCTAssertEqual(model?.ScheduleDescription, "string")
        XCTAssertEqual(model?.MaintenanceCategory, "string")
        XCTAssertEqual(model?.MaintenanceName, "string")
        XCTAssertEqual(model?.MaintenanceNotes, "string")
        XCTAssertNotNil(model?.Intervals)
        XCTAssertNotNil(model?.Events)
    }
}
