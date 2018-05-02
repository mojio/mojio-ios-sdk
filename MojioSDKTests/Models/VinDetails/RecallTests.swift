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
import XCTest

class RecallTest: XCTestCase {
    func testRecallModelShouldBeCreatedFromJsonString() {
        let jsonString = """
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
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Recall>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Title, "string")
        XCTAssertEqual(model?.NHTSACampaignNumber, "string")
        XCTAssertEqual(model?.MFRCampaignNumber, "string")
        XCTAssertEqual(model?.ComponentDescription, "string")
        XCTAssertEqual(model?.ReportManufacturer, "string")
        XCTAssertEqual(model?.ManufacturingStartDate, "string")
        XCTAssertEqual(model?.ManufacturingEndDate, "string")
        XCTAssertEqual(model?.RecallTypeCode, "string")
        XCTAssertEqual(model?.PotentialUnitsAffected, "string")
        XCTAssertEqual(model?.OwnerNotificationDate, "string")
        XCTAssertEqual(model?.RecallInitiator, "string")
        XCTAssertEqual(model?.ProductManufacturer, "string")
        XCTAssertEqual(model?.ReportReceivedDate, "string")
        XCTAssertEqual(model?.RecordCreationDate, "string")
        XCTAssertEqual(model?.RegulationPartNumber, "string")
        XCTAssertEqual(model?.FMVVSNumber, "string")
        XCTAssertEqual(model?.DefectSummary, "string")
        XCTAssertEqual(model?.ConsequenceSummary, "string")
        XCTAssertEqual(model?.CorrectiveAction, "string")
        XCTAssertEqual(model?.Notes, "string")
        XCTAssertEqual(model?.RecalledComponentId, "string")
    }
}
