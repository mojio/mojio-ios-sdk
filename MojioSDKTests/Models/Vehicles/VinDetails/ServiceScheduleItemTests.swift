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

class ServiceScheduleItemTests: XCTestCase {
    
    var model: ServiceScheduleItem!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(ServiceScheduleItem.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testServiceScheduleItemModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testServiceIntervalModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(ServiceScheduleItem.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: ServiceScheduleItem?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.transNotes, "string")
            XCTAssertEqual(model.scheduleName, "string")
            XCTAssertEqual(model.scheduleDescription, "string")
            XCTAssertEqual(model.maintenanceCategory, "string")
            XCTAssertEqual(model.maintenanceName, "string")
            XCTAssertEqual(model.maintenanceNotes, "string")
            XCTAssertNotNil(model.intervals)
            XCTAssertNotNil(model.events)
        }
    }
}

extension ServiceScheduleItemTests {
    var jsonString: String {
        return """
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
                "Value": 0,
                "Units": "string",
                "InitialValue": 0
            }],
            "Events": [{
                "ComputerCode": "string",
                "Event": "string"
            }]
        }
        """
    }
}









