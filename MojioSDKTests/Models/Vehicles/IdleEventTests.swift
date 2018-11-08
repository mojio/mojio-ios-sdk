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

class IdleEventTests: XCTestCase {
    
    var model: IdleEvent!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(IdleEvent.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testIdleEventModelDecoding() {
        helperMethod(_model: model)
    }
    
    func testIdleEventModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(IdleEvent.self, from: encodedModelData)
            
            helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: IdleEvent?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertNotNil(model.eventLocation)
            XCTAssertNotNil(model.eventState)
        }
    }
}

extension IdleEventTests {
    var jsonString: String {
        return """
        {
            "IdleState": {
                "Timestamp": "2017-11-09T07:15:16.084Z",
                "Value": true,
                "StartTime": "2017-11-09T07:15:16.084Z",
                "Duration": {
                    "BaseUnit": "Ticks",
                    "Timestamp": "2017-11-09T07:15:16.084Z",
                    "BaseValue": 0,
                    "Unit": "brrrr",
                    "Value": 0
                }
            },
            "Location": {
                "Timestamp": "2017-11-09T07:15:16.084Z",
                "Lat": 0,
                "Lng": 0,
                "Status": "Unknown",
                "Dilution": 0,
                "Radius": 15,
                "Altitude": 0,
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



