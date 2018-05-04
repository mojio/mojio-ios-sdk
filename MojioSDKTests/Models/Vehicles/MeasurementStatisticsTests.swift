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

class MeasurementStatisticsTests: XCTestCase {
    
    var model: MeasurementStatistics!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(MeasurementStatistics.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testMeasurementStatisticsModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.numOfSamples, 1.0)
        XCTAssertEqual(model?.average, 2.0)
        XCTAssertEqual(model?.variance, 3.0)
        XCTAssertEqual(model?.stdDev, 4.0)
        XCTAssertEqual(model?.indexOfDispersion, 5.0)
        XCTAssertEqual(model?.coeffOfVariation, 6.0)
        XCTAssertEqual(model?.m2, 7.0)
        XCTAssertEqual(model?.min, 8.0)
        XCTAssertEqual(model?.max, 9.0)
        XCTAssertNotNil(model?.minMaxScore)
        XCTAssertNotNil(model?.standardScore)
    }
}

extension MeasurementStatisticsTests {
    var jsonString: String {
        return """
        {
        "NumOfSamples": 1,
        "Average": 2,
        "Variance": 3,
        "StdDev": 4,
        "IndexOfDispersion": 5,
        "CoeffOfVariation": 6,
        "M2": 7,
        "Min": 8,
        "Max": 9,
        "StandardScore": {
        "ScoringMethod": "string",
        "Value": 0,
        "Percentile": 0,
        "Average": 0
        },
        "MinMaxScore": {
        "ScoringMethod": "string",
        "Value": 0,
        "Percentile": 0,
        "Average": 0
        }
        }
        """
    }
}




