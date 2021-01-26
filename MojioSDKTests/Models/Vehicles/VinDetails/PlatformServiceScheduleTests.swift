/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

class PlatformServiceScheduleTests: XCTestCase {
    
    var model: PlatformServiceSchedule!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(PlatformServiceSchedule.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testPlatformServiceScheduleModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testPlatformServiceScheduleModelModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(PlatformServiceSchedule.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: PlatformServiceSchedule?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.initialValue, 0)
            XCTAssertEqual(model.value, 0)
            XCTAssertEqual(model.intervalType, "string")
            XCTAssertEqual(model.maintenanceCategory, "string")
            XCTAssertEqual(model.maintenanceName, "string")
            XCTAssertEqual(model.maintenanceNotes, "string")
            XCTAssertNotNil(model.operatingParameter, "string")
            XCTAssertNotNil(model.operatingParameterNotes, "string")
            XCTAssertNotNil(model.scheduleDescription, "string")
            XCTAssertNotNil(model.scheduleName, "string")
            XCTAssertNotNil(model.serviceEvent, "string")
            XCTAssertNotNil(model.transNotes, "string")
            XCTAssertNotNil(model.units, "string")
        }
    }
}

extension PlatformServiceScheduleTests {
    var jsonString: String {
        return """
        {
            "InitialValue": 0,
            "IntervalType": "string",
            "MaintenanceCategory": "string",
            "MaintenanceName": "string",
            "MaintenanceNotes": "string",
            "OperatingParameter": "string",
            "OperatingParameterNotes": "string",
            "ScheduleDescription": "string",
            "ScheduleName": "string",
            "ServiceEvent": "string",
            "TransNotes": "string",
            "Units": "string",
            "Value": 0,
        }
        """
    }
}




