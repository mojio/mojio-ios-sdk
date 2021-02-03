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

class HarshEventTests: XCTestCase {
    
    var model: HarshEvent!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(HarshEvent.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testHarshEventModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testHarshEventModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(HarshEvent.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: HarshEvent?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.eventLocation)
            XCTAssertNotNil(model.eventState)
        }
    }
}

extension HarshEventTests {
    var jsonString: String {
        return """
        {
            "HarshEventState": {
                "Timestamp": "2017-11-09T07:15:16.084Z",
                "Value": true,
                "EventType": "Acceleration",
                "TurnType": "Left"
            },
            "Location": {
                "Timestamp": "2017-11-09T07:15:16.084Z",
                "Lat": 0,
                "Lng": 0,
                "Status": "Unknown",
                "Dilution": 0,
                "Altitude": 0,
                "Radius": 15,
                "GeoHash": "string",
                "Heading": {
                    "BaseUnit": "Degree",
                    "Direction": "string",
                    "LeftTurn": true,
                    "Timestamp": "2017-11-09T07:15:16.084Z",
                    "BaseValue": 0,
                    "Unit": "Degree",
                    "Value": 0
                },
                "Address": {
                    "HouseNumber": "string",
                    "Road": "string",
                    "Neighbourhood": "string",
                    "Suburb": "string",
                    "City": "string",
                    "County": "string",
                    "State": "string",
                    "PostCode": "string",
                    "Country": "string",
                    "CountryCode": "string",
                    "FormattedAddress": "string"
                }
            }
        }
        """
    }
}


