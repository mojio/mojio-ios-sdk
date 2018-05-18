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

class NextServiceScheduleTests: XCTestCase {
    
    var model: NextServiceSchedule!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(NextServiceSchedule.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testNextServiceScheduleModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testNextServiceScheduleModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(NextServiceSchedule.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: NextServiceSchedule?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.odometer, 0)
            XCTAssertEqual(model.ageInMonths, 0)
            XCTAssertEqual(model.timeUnits, "string")
            XCTAssertEqual(model.timeValue, 0)
            XCTAssertEqual(model.distanceUnits, "string")
            XCTAssertEqual(model.distanceValue, 0)
            XCTAssertNotNil(model.services)
        }
    }
}

extension NextServiceScheduleTests {
    var jsonString: String {
        return """
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
            }]
        }
        """
    }
}



