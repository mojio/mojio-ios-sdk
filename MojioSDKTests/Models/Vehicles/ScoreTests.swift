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

class ScoreTests: XCTestCase {
    
    var model: Score!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Score.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testScoreModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testScoreModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Score.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Score?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.scoringMethod, .zScore)
            XCTAssertEqual(model.value, 10.0)
            XCTAssertEqual(model.percentile, 0.5)
            XCTAssertEqual(model.average, 20.0)
        }
    }
}

extension ScoreTests {
    var jsonString: String {
        return """
        {
            "ScoringMethod": "ZScore",
            "Value": 10.0,
            "Percentile": 0.5,
            "Average": 20.0
        }
        """
    }
}
