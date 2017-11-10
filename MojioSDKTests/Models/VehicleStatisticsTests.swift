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

class VehicleStatisticsTests: XCTestCase {
    func testVehicleStatisticsModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
          "EstimatedFuelLevel": {
            "BaseUnit": "string",
            "BaseValue": 10,
            "Unit": "string",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
          },
          "EstimatedFuelVolume": {
            "BaseUnit": "string",
            "BaseValue": 10,
            "Unit": "string",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
          },
          "AverageFuelEfficiency": {
            "BaseUnit": "string",
            "BaseValue": 10,
            "Unit": "string",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
          },
          "TotalRange": {
            "BaseUnit": "string",
            "BaseValue": 10,
            "Unit": "string",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
          },
          "CurrentRange": {
            "BaseUnit": "string",
            "BaseValue": 10,
            "Unit": "string",
            "Value": 20,
            "Timestamp": "2017-11-09T07:16:58.072Z"
          },
          "LastFillUpDate": "2017-11-09T07:16:58.072Z"
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<VehicleStatistics>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.EstimatedFuelLevel)
        XCTAssertNotNil(model?.EstimatedFuelVolume)
        XCTAssertNotNil(model?.AverageFuelEfficiency)
        XCTAssertNotNil(model?.TotalRange)
        XCTAssertNotNil(model?.CurrentRange)
        XCTAssertEqual(model?.LastFillUpDate, "2017-11-09T07:16:58.072Z")
    }
}
