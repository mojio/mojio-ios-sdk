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

class VinTests: XCTestCase {
    
    func testVinModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Vin>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.VIN, "string")
        XCTAssertEqual(model?.timestamp, "2017-11-10T07:07:45.359Z")
        XCTAssertEqual(model?.Market, "string")
        XCTAssertEqual(model?.Year, 0)
        XCTAssertEqual(model?.Make, "string")
        XCTAssertEqual(model?.Model, "string")
        XCTAssertEqual(model?.VehicleType, "string")
        XCTAssertEqual(model?.BodyType, "string")
        XCTAssertEqual(model?.DriveType, "string")
        XCTAssertEqual(model?.FuelTankSize, 0)
        XCTAssertEqual(model?.EPAFuelEfficiency, 0)
        XCTAssertNotNil(model?.VehicleEngine)
        XCTAssertNotNil(model?.VehicleTransmission)
        XCTAssertNotNil(model?.Warranties)
        XCTAssertNotNil(model?.Recalls)
        XCTAssertNotNil(model?.ServiceBulletins)
    }
}

extension VinTests {
    var jsonString: String {
        return """
        {
        "VIN": "string",
        "timestamp": "2017-11-10T07:07:45.359Z",
        "Market": "string",
        "Year": 0,
        "Make": "string",
        "Model": "string",
        "VehicleType": "string",
        "BodyType": "string",
        "DriveType": "string",
        "FuelTankSize": "string",
        "EPAFuelEfficiency": 0,
        "Engine": {
        "Name": "string",
        "Cylinders": "string",
        "Displacement": "string",
        "FuelInduction": "string",
        "FuelQuality": "string",
        "FuelType": "string",
        "MaxHp": "string",
        "MaxHpAt": "string"
        },
        "Transmission": {
        "Name": "string",
        "Type": "string",
        "DetailType": "string",
        "Gears": "string"
        },
        "Warranties": [
        {
        "Name": "string",
        "Type": "string",
        "Months": "string",
        "Km": 0
        }
        ],
        "Recalls": [
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
        ],
        "ServiceBulletins": [
        {
        "ItemNumber": "string",
        "BulletinNumber": "string",
        "ReplacementBulletinNumber": "string",
        "DateAdded": "string",
        "Component": "string",
        "BulletinDate": "string",
        "Summary": "string"
        }
        ]
        }
        """
    }
}
