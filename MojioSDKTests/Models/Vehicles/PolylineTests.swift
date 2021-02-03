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

class PolylineTests: XCTestCase {
    
    var model: Polyline!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Polyline.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testPolylineModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testPolylineModelModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Polyline.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Polyline?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.id, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.polyline, "string")
            XCTAssertEqual(model.deleted, true)
        }
    }
}

extension PolylineTests {
    var jsonString: String {
        return """
        {
            "Polyline": "string",
            "Id": "00000000-0000-0000-0000-000000000000",
            "CreatedOn": "2017-11-10T07:07:42.040Z",
            "LastModified": "2017-11-10T07:07:42.040Z",
            "Deleted": true
        }
        """
    }
}
