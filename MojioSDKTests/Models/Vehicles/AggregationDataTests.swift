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

class AggregationDataTests: XCTestCase {
    
    var model: AggregationData!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(AggregationData.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    //MARK: - CHECK DATE
    func testAggregationDataDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testAggregationDataModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(AggregationData.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: AggregationData?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.total, 12)
            XCTAssertEqual(model.average, 15)
            XCTAssertEqual(model.max, 21)
            XCTAssertEqual(model.min, 1)
            XCTAssertEqual(model.units, "MetersPerSecondPerSecond")
            XCTAssertEqual(model.count, 31)
            XCTAssertEqual(model.tripCount, 5)
        }
    }
}

extension AggregationDataTests {
    var jsonString: String {
        return """
        {
            "Total": 12,
            "Average": 15,
            "Max": 21,
            "Min": 1,
            "Units": "MetersPerSecondPerSecond",
            "Date": "2017-11-09T07:16:58.072Z",
            "EndDate": "2017-11-09T07:16:58.072Z",
            "Count": 31,
            "TripCount": 5
        }
        """
    }
}
