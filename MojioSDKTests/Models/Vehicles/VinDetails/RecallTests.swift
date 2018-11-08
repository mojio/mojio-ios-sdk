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

class RecallTests: XCTestCase {
    
    var model: Recall!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Recall.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testRecallModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testRecallModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Recall.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Recall?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.title, "string")
            XCTAssertEqual(model.nhtsaCampaignNumber, "string")
            XCTAssertEqual(model.mfrCampaignNumber, "string")
            XCTAssertEqual(model.componentDescription, "string")
            XCTAssertEqual(model.reportManufacturer, "string")
            XCTAssertEqual(model.recallTypeCode, "string")
            XCTAssertEqual(model.potentialUnitsAffected, "string")
            XCTAssertEqual(model.recallInitiator, "string")
            XCTAssertEqual(model.productManufacturer, "string")
            XCTAssertEqual(model.regulationPartNumber, "string")
            XCTAssertEqual(model.fmvvsNumber, "string")
            XCTAssertEqual(model.defectSummary, "string")
            XCTAssertEqual(model.consequenceSummary, "string")
            XCTAssertEqual(model.correctiveAction, "string")
            XCTAssertEqual(model.notes, "string")
            XCTAssertEqual(model.recalledComponentId, "string")
        }
    }
}

extension RecallTests {
    var jsonString: String {
        return """
        {
            "Title": "string",
            "NHTSACampaignNumber": "string",
            "MFRCampaignNumber": "string",
            "ComponentDescription": "string",
            "ReportManufacturer": "string",
            "ManufacturingStartDate": "string",
            "ManufacturingEndDate": "string",
            "RecallTypeCode": "string",
            "PotentialUnitsAffected": "string",
            "OwnerNotificationDate": "string",
            "RecallInitiator": "string",
            "ProductManufacturer": "string",
            "ReportReceivedDate": "string",
            "RecordCreationDate": "string",
            "RegulationPartNumber": "string",
            "FMVVSNumber": "string",
            "DefectSummary": "string",
            "ConsequenceSummary": "string",
            "CorrectiveAction": "string",
            "Notes": "string",
            "RecalledComponentId": "string"
        }
        """
    }
}





