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

class VehicleTests: XCTestCase {
    
    var model: Vehicle!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Vehicle.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testVehicleModelDecoding() {
        self.helperMethod(_model: self.model)
    }
    
    func testVehicleModelEncoding() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encodedModelData = try encoder.encode(self.model)
            
            XCTAssertNotNil(encodedModelData)
            
            let modelDecodedAgain = try JSONDecoder().decode(Vehicle.self, from: encodedModelData)
            
            self.helperMethod(_model: modelDecodedAgain)
        } catch let error {
            print(error)
        }
    }
    
    func helperMethod(_model: Vehicle?) {
        if let model = _model {
            XCTAssertNotNil(model)
            XCTAssertEqual(model.name, "string")
            XCTAssertEqual(model.licensePlate, "string")
            XCTAssertEqual(model.vin, "string")
            XCTAssertEqual(model.detectedVIN, "string")
            XCTAssertEqual(model.overrideVIN, "string")
            XCTAssertNotNil(model.compatDetails)
            XCTAssertEqual(model.currentTrip, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.mojioId, "00000000-0000-0000-0000-000000000000")
            XCTAssertEqual(model.milStatus, true)
            XCTAssertNotNil(model.diagnosticCodes)
            XCTAssertNotNil(model.accelerometer)
            XCTAssertNotNil(model.acceleration)
            XCTAssertNotNil(model.deceleration)
            XCTAssertNotNil(model.speed)
            XCTAssertNotNil(model.odometer)
            XCTAssertNotNil(model.virtualOdometer)
            XCTAssertNotNil(model.realOdometer)
            XCTAssertNotNil(model.rpm)
            XCTAssertNotNil(model.fuelEfficiency)
            XCTAssertEqual(model.fuelEfficiencyCalculationMethod, .query)
            XCTAssertEqual(model.fuelType, .query)
            XCTAssertNotNil(model.fuelLevel)
            XCTAssertNotNil(model.fuelVolume)
            XCTAssertNotNil(model.harshEventState)
            XCTAssertNotNil(model.idleState)
            XCTAssertNotNil(model.ignitionState)
            XCTAssertNotNil(model.battery)
            XCTAssertNotNil(model.heading)
            XCTAssertNotNil(model.location)
            XCTAssertNotNil(model.accidentState)
            XCTAssertNotNil(model.vinDetails)
            XCTAssertNotNil(model.towState)
            XCTAssertNotNil(model.parkedState)
            XCTAssertNotNil(model.predictiveMaintenance?.airFilter)
            XCTAssert(model.predictiveMaintenance!.airFilter!.warning)
            XCTAssertNotNil(model.predictiveMaintenance?.battery)
            XCTAssert(model.predictiveMaintenance!.battery!.warning)
            XCTAssertNotNil(model.ownerGroups)
            XCTAssertEqual(model.id, "00000000-0000-0000-0000-000000000000")
            XCTAssertNotNil(model.tags)
            XCTAssertEqual(model.deleted, true)
        }
    }
}

extension VehicleTests {
    var jsonString: String {
        return """
        {
            "Name": "string",
            "LicensePlate": "string",
            "DetectedVIN": "string",
            "OverrideVIN": "string",
            "VIN": "string",
            "CompatDetails": {
                "Level": "Full",
                "LastChecked": "2017-11-10T07:07:45.030Z",
                "Changed": true
            },
            "CurrentTrip": "00000000-0000-0000-0000-000000000000",
            "MojioId": "00000000-0000-0000-0000-000000000000",
            "OwnerId": "00000000-0000-0000-0000-000000000000",
            "WithinGeofences": [
                "00000000-0000-0000-0000-000000000000"
            ],
            "MilStatus": true,
            "LastContactTime": "2017-11-10T07:07:45.030Z",
            "DiagnosticCodes": [{
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "Code": "string",
                "Description": "string",
                "Type": "Standard",
                "StateType": "Current",
                "Severity": "Unknown",
                "Instructions": "string",
                "Ignored": true
            }],
            "Accelerometer": {
                "X": {
                    "BaseUnit": "MilliGUnits",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "MilliGUnits",
                    "Value": 0
                },
                "Y": {
                    "BaseUnit": "MilliGUnits",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "MilliGUnits",
                    "Value": 0
                },
                "Z": {
                    "BaseUnit": "MilliGUnits",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "MilliGUnits",
                    "Value": 0
                },
                "Magnitude": {
                    "BaseUnit": "MilliGUnits",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "MilliGUnits",
                    "Value": 0
                },
                "SamplingInterval": {
                    "BaseUnit": "Ticks",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "Ticks",
                    "Value": 0
                }
            },
            "Acceleration": {
                "BaseUnit": "MetersPerSecondPerSecond",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "MetersPerSecondPerSecond",
                "Value": 0
            },
            "Deceleration": {
                "BaseUnit": "MetersPerSecondPerSecond",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "MetersPerSecondPerSecond",
                "Value": 0
            },
            "Speed": {
                "BaseUnit": "KilometersPerHour",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "KilometersPerHour",
                "Value": 0
            },
            "Odometer": {
                "RolloverValue": 0,
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            },
            "RPM": {
                "BaseUnit": "RevolutionsPerMinute",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "RevolutionsPerMinute",
                "Value": 0
            },
            "FuelEfficiency": {
                "BaseUnit": "MilesPerGallon",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "MilesPerGallon",
                "Value": 0
            },
            "DisturbanceState": {
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "Value": true
            },
            "FuelEfficiencyCalculationMethod": "Query",
            "FuelLevel": {
                "BaseUnit": "Percentage",
                "RiskSeverity": "High",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "Percentage",
                "Value": 0
            },
            "FuelVolume": {
                "BaseUnit": "Gill",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "Gill",
                "Value": 0
            },
            "VirtualFuelConsumption": {
                "BaseUnit": "Gill",
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "BaseValue": 0,
                "Unit": "Gill",
                "Value": 0
            },
            "FuelType": "Query",
            "GatewayTime": "2017-11-10T07:07:45.030Z",
            "HarshEventState": {
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "Value": true,
                "EventType": "Acceleration",
                "TurnType": "Left"
            },
            "IdleState": {
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "Value": true,
                "StartTime": "2017-11-10T07:07:45.030Z",
                "Duration": {
                    "BaseUnit": "Ticks",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "Ticks",
                    "Value": 0
                }
            },
            "IgnitionState": {
                "Timestamp": "2017-11-10T07:07:45.030Z",
                "Value": true
            },
            "Battery": {
                "Connected": true,
                "RiskSeverity": "Unknown",
                "LowVoltageDuration": {
                    "BaseUnit": "Ticks",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "Ticks",
                    "Value": 0
                },
                "HighVoltageDuration": {
                    "BaseUnit": "Ticks",
                    "Timestamp": "2017-11-10T07:07:45.030Z",
                    "BaseValue": 0,
                    "Unit": "Ticks",
                    "Value": 0
                },
                "BaseUnit": "MilliVolts",
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "BaseValue": 0,
                "Unit": "MilliVolts",
                "Value": 0
            },
            "Heading": {
                "BaseUnit": "Degree",
                "Direction": "string",
                "LeftTurn": true,
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "BaseValue": 0,
                "Unit": "Degree",
                "Value": 0
            },
            "Location": {
                "Timestamp": "2017-11-10T07:07:45.031Z",
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
                    "Timestamp": "2017-11-10T07:07:45.031Z",
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
            "AccidentState": {
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "Value": true
            },
            "VinDetails": {
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "Vin": "string",
                "Year": 0,
                "Make": "string",
                "Model": "string",
                "Engine": "string",
                "Cylinders": 0,
                "TotalFuelCapacity": {
                    "BaseUnit": "Gallons",
                    "Timestamp": "2017-11-10T07:07:45.031Z",
                    "BaseValue": 0,
                    "Unit": "Gallons",
                    "Value": 0
                },
                "FuelType": "string",
                "CityFuelEfficiency": 0,
                "HighwayFuelEfficiency": 0,
                "CombinedFuelEfficiency": 0,
                "Transmission": "string",
                "Message": "string",
                "Success": true
            },
            "TowState": {
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "Value": true,
                "Type": "TiltDetected"
            },
            "ParkedState": {
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "Value": true
            },
            "Tags": [
                "string"
            ],
            "PredictiveMaintenance": {
                "Battery": {
                    "Timestamp": "2019-11-08T01:01:06.786Z",
                    "Warning": true
                },
                "AirFilter": {
                    "Timestamp": "2019-11-08T01:01:22.836Z",
                    "Warning": true
                }
            },
            "VirtualOdometer": {
                "RolloverValue": 0,
                "BaseUnit": "Meters",
                "Timestamp": "2017-11-10T07:07:45.031Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
            },
            "RealOdometer": {
                "RolloverValue": 0,
                "BaseUnit": "Meters",
                "Timestamp": "2019-12-10T09:00:31.438Z",
                "BaseValue": 0,
                "Unit": "Meters",
                "Value": 0
        },
            "Id": "00000000-0000-0000-0000-000000000000",
            "CreatedOn": "2017-11-10T07:07:45.031Z",
            "LastModified": "2017-11-10T07:07:45.031Z",
            "Deleted": true,
            "Metadata": {},
            "Links": {}
        }
        """
    }
}



