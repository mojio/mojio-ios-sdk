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

class VehicleTests: XCTestCase {
    func testVehicleModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Vehicle>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.LicensePlate, "string")
        XCTAssertEqual(model?.VIN, "string")
        XCTAssertEqual(model?.DetectedVIN, "string")
        XCTAssertEqual(model?.OverrideVIN, "string")
        XCTAssertNotNil(model?.CompatDetails)
        XCTAssertEqual(model?.CurrentTrip, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.MojioId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.MilStatus, true)
        XCTAssertNotNil(model?.DiagnosticCodes)
        XCTAssertEqual(model?.LastContactTime, "2017-11-10T07:07:45.030Z")
        XCTAssertNotNil(model?.VehicleAccelerometer)
        XCTAssertNotNil(model?.VehicleAcceleration)
        XCTAssertNotNil(model?.Deceleration)
        XCTAssertNotNil(model?.VehicleSpeed)
        XCTAssertNotNil(model?.VehicleOdometer)
        XCTAssertNotNil(model?.VirtualOdometer)
        XCTAssertNotNil(model?.VehicleRPM)
        XCTAssertNotNil(model?.VehicleFuelEfficiency)
        XCTAssertEqual(model?.FuelEfficiencyCalculationMethod, "Query")
        XCTAssertNotNil(model?.VehicleFuelLevel)
        XCTAssertNotNil(model?.VehicleFuelVolume)
        XCTAssertEqual(model?.FuelType, "Query")
        XCTAssertEqual(model?.GatewayTime, "2017-11-10T07:07:45.030Z")
        XCTAssertNotNil(model?.VehicleHarshEventState)
        XCTAssertNotNil(model?.VehicleIdleState)
        XCTAssertNotNil(model?.VehicleIgnitionState)
        XCTAssertNotNil(model?.VehicleBattery)
        XCTAssertNotNil(model?.VehicleHeading)
        XCTAssertNotNil(model?.VehicleLocation)
        XCTAssertNotNil(model?.VehicleAccidentState)
        XCTAssertNotNil(model?.VehicleVinDetails)
        XCTAssertNotNil(model?.VehicleTowState)
        XCTAssertNotNil(model?.VehicleParkedState)
        XCTAssertNotNil(model?.OwnerGroups)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertNotNil(model?.Tags)
        XCTAssertEqual(model?.CreatedOn, "2017-11-10T07:07:45.031Z")
        XCTAssertEqual(model?.LastModified, "2017-11-10T07:07:45.031Z")
        XCTAssertEqual(model?.Deleted, true)
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
        "Image": {
        "Src": "string",
        "Normal": "string",
        "Thumbnail": "string"
        },
        "MilStatus": true,
        "LastContactTime": "2017-11-10T07:07:45.030Z",
        "DiagnosticCodes": [
        {
        "timestamp": "2017-11-10T07:07:45.030Z",
        "Code": "string",
        "Description": "string",
        "Type": "Standard",
        "StateType": "Current",
        "Severity": "Unknown",
        "Instructions": "string",
        "Ignored": true
        }
        ],
        "Accelerometer": {
        "X": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Y": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Z": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "Magnitude": {
        "baseUnit": "MilliGUnits",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MilliGUnits",
        "value": 0
        },
        "SamplingInterval": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        }
        },
        "Acceleration": {
        "baseUnit": "MetersPerSecondPerSecond",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MetersPerSecondPerSecond",
        "value": 0
        },
        "Deceleration": {
        "baseUnit": "MetersPerSecondPerSecond",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MetersPerSecondPerSecond",
        "value": 0
        },
        "Speed": {
        "baseUnit": "KilometersPerHour",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "KilometersPerHour",
        "value": 0
        },
        "Odometer": {
        "RolloverValue": 0,
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "RPM": {
        "baseUnit": "RevolutionsPerMinute",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "RevolutionsPerMinute",
        "value": 0
        },
        "FuelEfficiency": {
        "baseUnit": "MilesPerGallon",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "MilesPerGallon",
        "value": 0
        },
        "DisturbanceState": {
        "timestamp": "2017-11-10T07:07:45.030Z",
        "value": true
        },
        "FuelEfficiencyCalculationMethod": "Query",
        "FuelLevel": {
        "baseUnit": "Percentage",
        "RiskSeverity": "Unknown",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Percentage",
        "value": 0
        },
        "FuelVolume": {
        "baseUnit": "Gill",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Gill",
        "value": 0
        },
        "VirtualFuelConsumption": {
        "baseUnit": "Gill",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Gill",
        "value": 0
        },
        "FuelType": "Query",
        "GatewayTime": "2017-11-10T07:07:45.030Z",
        "HarshEventState": {
        "timestamp": "2017-11-10T07:07:45.030Z",
        "value": true,
        "EventType": "Acceleration",
        "TurnType": "Left"
        },
        "IdleState": {
        "timestamp": "2017-11-10T07:07:45.030Z",
        "value": true,
        "StartTime": "2017-11-10T07:07:45.030Z",
        "Duration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        }
        },
        "IgnitionState": {
        "timestamp": "2017-11-10T07:07:45.030Z",
        "value": true
        },
        "Battery": {
        "Connected": true,
        "RiskSeverity": "Unknown",
        "LowVoltageDuration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        },
        "HighVoltageDuration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-10T07:07:45.030Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        },
        "baseUnit": "MilliVolts",
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "MilliVolts",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "Degree",
        "value": 0
        },
        "Location": {
        "timestamp": "2017-11-10T07:07:45.031Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "Degree",
        "value": 0
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
        "timestamp": "2017-11-10T07:07:45.031Z",
        "value": true
        },
        "VinDetails": {
        "timestamp": "2017-11-10T07:07:45.031Z",
        "Vin": "string",
        "Year": 0,
        "Make": "string",
        "Model": "string",
        "Engine": "string",
        "Cylinders": 0,
        "TotalFuelCapacity": {
        "baseUnit": "Gallons",
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "Gallons",
        "value": 0
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
        "timestamp": "2017-11-10T07:07:45.031Z",
        "value": true,
        "Type": "TiltDetected"
        },
        "ParkedState": {
        "timestamp": "2017-11-10T07:07:45.031Z",
        "value": true
        },
        "Tags": [
        "string"
        ],
        "VirtualOdometer": {
        "RolloverValue": 0,
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:45.031Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
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
