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

class TripTests: XCTestCase {
    
    func testTripModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Trip>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.VehicleId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.MojioId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.OwnerId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Completed, true)
        XCTAssertEqual(model?.TripDuration, "string")
        XCTAssertNotNil(model?.TripDistance)
        XCTAssertEqual(model?.StartTimestamp, "2017-11-10T07:07:44.298Z")
        XCTAssertEqual(model?.EndTimestamp, "2017-11-10T07:07:44.298Z")
        XCTAssertNotNil(model?.StartOdometer)
        XCTAssertNotNil(model?.EndOdometer)
        XCTAssertNotNil(model?.StartLocation)
        XCTAssertNotNil(model?.EndLocation)
        XCTAssertNotNil(model?.MaxSpeed)
        XCTAssertNotNil(model?.MaxRPM)
        XCTAssertNotNil(model?.MaxAcceleration)
        XCTAssertNotNil(model?.MaxDeceleration)
        XCTAssertEqual(model?.Polyline, "string")
        XCTAssertNotNil(model?.HarshEvents)
        XCTAssertNotNil(model?.IdleEvents)
        XCTAssertNotNil(model?.TripFuelEfficiency)
        XCTAssertNotNil(model?.StartFuelLevel)
        XCTAssertNotNil(model?.EndFuelLevel)
        XCTAssertEqual(model?.IdlingCount, 0)
        XCTAssertEqual(model?.HarshAccelCount, 0)
        XCTAssertEqual(model?.HarshDecelCount, 0)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-10T07:07:44.300Z")
        XCTAssertEqual(model?.LastModified, "2017-11-10T07:07:44.300Z")
        XCTAssertNotNil(model?.Tags)
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
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.298Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "EndOdometer": {
        "RolloverValue": 0,
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.298Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "StartLocation": {
        "timestamp": "2017-11-10T07:07:44.298Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.298Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:44.298Z",
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
        "EndLocation": {
        "timestamp": "2017-11-10T07:07:44.299Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:44.299Z",
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
        "Distance": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "MaxSpeed": {
        "baseUnit": "KilometersPerHour",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "KilometersPerHour",
        "value": 0
        },
        "MaxRPM": {
        "baseUnit": "RevolutionsPerMinute",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "RevolutionsPerMinute",
        "value": 0
        },
        "MaxAcceleration": {
        "baseUnit": "MetersPerSecondPerSecond",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "MetersPerSecondPerSecond",
        "value": 0
        },
        "MaxDeceleration": {
        "baseUnit": "MetersPerSecondPerSecond",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "MetersPerSecondPerSecond",
        "value": 0
        },
        "Polyline": "string",
        "HarshEvents": [
        {
        "HarshEventState": {
        "timestamp": "2017-11-10T07:07:44.299Z",
        "value": true,
        "EventType": "Acceleration",
        "TurnType": "Left"
        },
        "Location": {
        "timestamp": "2017-11-10T07:07:44.299Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:44.299Z",
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
        }
        }
        ],
        "IdleEvents": [
        {
        "IdleState": {
        "timestamp": "2017-11-10T07:07:44.299Z",
        "value": true,
        "StartTime": "2017-11-10T07:07:44.299Z",
        "Duration": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-10T07:07:44.299Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        }
        },
        "Location": {
        "timestamp": "2017-11-10T07:07:44.299Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-10T07:07:44.300Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-10T07:07:44.300Z",
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
        }
        }
        ],
        "FuelEfficiency": {
        "baseUnit": "MilesPerGallon",
        "timestamp": "2017-11-10T07:07:44.300Z",
        "baseValue": 0,
        "unit": "MilesPerGallon",
        "value": 0
        },
        "StartFuelLevel": {
        "baseUnit": "Percentage",
        "RiskSeverity": "Unknown",
        "timestamp": "2017-11-10T07:07:44.300Z",
        "baseValue": 0,
        "unit": "Percentage",
        "value": 0
        },
        "HarshAcclCount": 0,
        "HarshDecelCount": 0,
        "IdlingCount": 0,
        "EndFuelLevel": {
        "baseUnit": "Percentage",
        "RiskSeverity": "Unknown",
        "timestamp": "2017-11-10T07:07:44.300Z",
        "baseValue": 0,
        "unit": "Percentage",
        "value": 0
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
