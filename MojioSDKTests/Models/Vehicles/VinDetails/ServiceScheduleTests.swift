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

class ServiceScheduleTests: XCTestCase {
    
    var model: ServiceSchedule!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(ServiceSchedule.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testServiceScheduleModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.vin, "string")
        XCTAssertEqual(model?.isDefault, true)
        XCTAssertNotNil(model?.items)
    }
}

extension ServiceScheduleTests {
    var jsonString: String {
        return """
        {
        "VIN": "string",
        "IsDefault": true,
        "Items": [{
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
        }]}]
        }
        """
    }
}










