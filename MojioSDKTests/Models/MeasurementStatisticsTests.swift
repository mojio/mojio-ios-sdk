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

class MeasurementStatisticsTests: XCTestCase {

    func testMeasurementStatisticsShouldBeCreatedFromJsonString() {
        let jsonString = """
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
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<MeasurementStatistics>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.NumOfSamples, 1.0)
        XCTAssertEqual(model?.Average, 2.0)
        XCTAssertEqual(model?.Variance, 3.0)
        XCTAssertEqual(model?.StdDev, 4.0)
        XCTAssertEqual(model?.IndexOfDispersion, 5.0)
        XCTAssertEqual(model?.CoeffOfVariation, 6.0)
        XCTAssertEqual(model?.M2, 7.0)
        XCTAssertEqual(model?.Min, 8.0)
        XCTAssertEqual(model?.Max, 9.0)
        XCTAssertNotNil(model?.MinMaxScore)
        XCTAssertNotNil(model?.StandardScore)
    }
}
