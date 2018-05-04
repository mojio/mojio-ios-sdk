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

class VinTests: XCTestCase {
    
    var model: Vin!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Vin.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testVinModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.vin, "string")
        XCTAssertEqual(model?.market, "string")
        XCTAssertEqual(model?.year, 0)
        XCTAssertEqual(model?.make, "string")
        XCTAssertEqual(model?.model, "string")
        XCTAssertEqual(model?.vehicleType, "string")
        XCTAssertEqual(model?.bodyType, "string")
        XCTAssertEqual(model?.driveType, "string")
        XCTAssertEqual(model?.fuelTankSize, 0)
        XCTAssertEqual(model?.epaFuelEfficiency, 0)
        XCTAssertNotNil(model?.vehicleEngine)
        XCTAssertNotNil(model?.vehicleTransmission)
        XCTAssertNotNil(model?.warranties)
        XCTAssertNotNil(model?.recalls)
        XCTAssertNotNil(model?.serviceBulletins)
    }
}

extension VinTests {
    var jsonString: String {
        return """
        {
        "VIN": "string",
        "Timestamp": "2017-11-10T07:07:45.359Z",
        "Market": "string",
        "Year": 0,
        "Make": "string",
        "Model": "string",
        "VehicleType": "string",
        "BodyType": "string",
        "DriveType": "string",
        "FuelTankSize": 0,
        "EPAFuelEfficiency": 0,
        "Engine": {
        "Name": "string",
        "Cylinders": "string",
        "Displacement": 0,
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












