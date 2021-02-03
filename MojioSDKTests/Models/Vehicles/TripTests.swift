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

class TripTests: XCTestCase {
    
    var model: Trip!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Trip.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testTripModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testTripModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Trip.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Trip?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.vehicleId, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.name, "string")
            XCTAssertEqual(model.mojioId, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.ownerId, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.completed, true)
            XCTAssertNotNil(model.distance)
            XCTAssertNotNil(model.startOdometer)
            XCTAssertNotNil(model.endOdometer)
            XCTAssertNotNil(model.startLocation)
            XCTAssertNotNil(model.endLocation)
            XCTAssertNotNil(model.maxSpeed)
            XCTAssertNotNil(model.maxRPM)
            XCTAssertNotNil(model.maxAcceleration)
            XCTAssertNotNil(model.maxDeceleration)
            XCTAssertEqual(model.polyline, "string")
            XCTAssertNotNil(model.harshEvents)
            XCTAssertNotNil(model.idleEvents)
            XCTAssertNotNil(model.startFuelLevel)
            XCTAssertNotNil(model.endFuelLevel)
            XCTAssertEqual(model.idlingCount, 0)
            XCTAssertEqual(model.harshAccelCount, 0)
            XCTAssertEqual(model.harshDecelCount, 0)
            XCTAssertEqual(model.id, "00000000-0000-0000-0000-000000000000")
            XCTAssertNotNil(model.tags)
        }
    }
}

extension TripTests {
    var jsonString: String {
        return """
        {
            "VehicleId": "00000000-0000-0000-0000-000000000000",
            "Name": "string",
            "Tags": [
                "string"
            ],
            "MojioId": "00000000-0000-0000-0000-000000000000",
            "OwnerId": "00000000-0000-0000-0000-000000000000",
            "Completed": true,
            "Duration": "string",
            "StartTimestamp": "2017-11-10T07:07:44.298Z",
            "EndTimestamp": "2017-11-10T07:07:44.298Z",
            "StartOdometer": {
                "RolloverValue": 0,
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-10T07:07:44.298Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            },
            "EndOdometer": {
                "RolloverValue": 0,
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-10T07:07:44.298Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            },
            "StartLocation": {
                "Timestamp": "2017-11-10T07:07:44.298Z",
                "Lat": 0,
                "Lng": 0,
                "Status": "Unknown",
                "Dilution": 0,
                "Altitude": 0,
                "GeoHash": "string",
                "Heading": {
                    "BaseUnit": "Degree",
                    "Direction": "string",
                    "LeftTurn": true,
                    "Timestamp": "2017-11-10T07:07:44.298Z",
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
            },
            "EndLocation": {
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "Lat": 0,
                "Lng": 0,
                "Status": "Unknown",
                "Dilution": 0,
                "Altitude": 0,
                "GeoHash": "string",
                "Heading": {
                    "BaseUnit": "Degree",
                    "Direction": "string",
                    "LeftTurn": true,
                    "Timestamp": "2017-11-10T07:07:44.299Z",
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
            },
            "Distance": {
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            },
            "MaxSpeed": {
                "BaseUnit": "KilometersPerHour",
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "BaseValue": 0,
                "Unit": "KilometersPerHour",
                "Value": 0
            },
            "MaxRPM": {
                "BaseUnit": "RevolutionsPerMinute",
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "BaseValue": 0,
                "Unit": "RevolutionsPerMinute",
                "Value": 0
            },
            "MaxAcceleration": {
                "BaseUnit": "MetersPerSecondPerSecond",
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "BaseValue": 0,
                "Unit": "MetersPerSecondPerSecond",
                "Value": 0
            },
            "MaxDeceleration": {
                "BaseUnit": "MetersPerSecondPerSecond",
                "Timestamp": "2017-11-10T07:07:44.299Z",
                "BaseValue": 0,
                "Unit": "MetersPerSecondPerSecond",
                "Value": 0
            },
            "Polyline": "string",
            "HarshEvents": [{
                "HarshEventState": {
                    "Timestamp": "2017-11-10T07:07:44.299Z",
                    "Value": true,
                    "EventType": "Acceleration",
                    "TurnType": "Left"
                },
                "Location": {
                    "Timestamp": "2017-11-10T07:07:44.299Z",
                    "Lat": 0,
                    "Lng": 0,
                    "Status": "Unknown",
                    "Dilution": 0,
                    "Altitude": 0,
                    "GeoHash": "string",
                    "Heading": {
                        "BaseUnit": "Degree",
                        "Direction": "string",
                        "LeftTurn": true,
                        "Timestamp": "2017-11-10T07:07:44.299Z",
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
            }],
            "IdleEvents": [{
                "IdleState": {
                    "Timestamp": "2017-11-10T07:07:44.299Z",
                    "Value": true,
                    "StartTime": "2017-11-10T07:07:44.299Z",
                    "Duration": {
                        "BaseUnit": "Ticks",
                        "Timestamp": "2017-11-10T07:07:44.299Z",
                        "BaseValue": 0,
                        "Unit": "Ticks",
                        "Value": 0
                    }
                },
                "Location": {
                    "Timestamp": "2017-11-10T07:07:44.299Z",
                    "Lat": 0,
                    "Lng": 0,
                    "Status": "Unknown",
                    "Dilution": 0,
                    "Altitude": 0,
                    "GeoHash": "string",
                    "Heading": {
                        "BaseUnit": "Degree",
                        "Direction": "string",
                        "LeftTurn": true,
                        "Timestamp": "2017-11-10T07:07:44.300Z",
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
            }],
            "FuelEfficiency": {
                "BaseUnit": "MilesPerGallon",
                "Timestamp": "2017-11-10T07:07:44.300Z",
                "BaseValue": 0,
                "Unit": "MilesPerGallon",
                "Value": 0
            },
            "StartFuelLevel": {
                "BaseUnit": "Percentage",
                "RiskSeverity": "Unknown",
                "Timestamp": "2017-11-10T07:07:44.300Z",
                "BaseValue": 0,
                "Unit": "Percentage",
                "Value": 0
            },
            "HarshAcclCount": 0,
            "HarshDecelCount": 0,
            "IdlingCount": 0,
            "EndFuelLevel": {
                "BaseUnit": "Percentage",
                "RiskSeverity": "Unknown",
                "Timestamp": "2017-11-10T07:07:44.300Z",
                "BaseValue": 0,
                "Unit": "Percentage",
                "Value": 0
            },
            "Id": "00000000-0000-0000-0000-000000000000",
            "CreatedOn": "2017-11-10T07:07:44.300Z",
            "LastModified": "2017-11-10T07:07:44.300Z",
            "Deleted": true,
            "Metadata": {},
            "Links": {}
        }
        """
    }
}


