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

class MojioTests: XCTestCase {
    
    var model: Mojio!
    
    override func setUp() {
        do {
            let data = self.jsonString.data(using: .utf8)
            self.model = try JSONDecoder().decode(Mojio.self, from: data!)
        } catch let error {
            print(error)
        }
    }
    
    override func tearDown() {
        
        self.model = nil
    }
    
    func testMojioModelDecoding() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.name, "string")
        XCTAssertEqual(model?.imei, "string")
        XCTAssertEqual(model?.vehicleId, "00000000-0000-0000-0000-000000000000")
        XCTAssertNotNil(model?.location)
        XCTAssertEqual(model?.tags[0], "string")
        XCTAssertNotNil(model?.wifi)
        XCTAssertNotNil(model?.connectedState)
        XCTAssertEqual(model?.deleted, true)
        XCTAssertEqual(model?.msisdn, "string")
        XCTAssertEqual(model?.iccid, "string")
    }
}

extension MojioTests {
    var jsonString: String {
        return """
        {
        "Name": "string",
        "IMEI": "string",
        "LastContactTime": "2017-11-09T07:16:57.426Z",
        "GatewayTime": "2017-11-09T07:16:57.426Z",
        "VehicleId": "00000000-0000-0000-0000-000000000000",
        "Location": {
        "Timestamp": "2017-11-09T07:16:57.426Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "BaseUnit": "Meters",
        "Timestamp": "2017-11-09T07:16:57.426Z",
        "BaseValue": 0,
        "Unit": "Meters",
        "Value": 0
        },
        "Heading": {
        "BaseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "Timestamp": "2017-11-09T07:16:57.426Z",
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
        "Tags": [
        "string"
        ],
        "WifiRadio": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "SSID": "string",
        "Password": "string",
        "AllowRoaming": true,
        "Status": "Unknown",
        "Strength": 0
        },
        "GPSRadio": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "NumberOfSattelitesForPositionFix": 0,
        "PDOP": 0,
        "HorizontalDilutionOfPrecision": 0,
        "VDOP": 0,
        "Location": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "BaseUnit": "Meters",
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "BaseValue": 0,
        "Unit": "Meters",
        "Value": 0
        },
        "Heading": {
        "BaseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "Timestamp": "2017-11-09T07:16:57.427Z",
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
        "HardwareAccuracyInMeters": 0,
        "PercentLostGPS": 0,
        "PercentLostGPSQ": 0,
        "Status": "Unknown",
        "Source": "GPS",
        "LostLockTime": {
        "BaseUnit": "Ticks",
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "BaseValue": 0,
        "Unit": "Ticks",
        "Value": 0
        },
        "Speed": {
        "BaseUnit": "KilometersPerHour",
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "BaseValue": 0,
        "Unit": "KilometersPerHour",
        "Value": 0
        }
        },
        "ConnectedState": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "Value": true
        },
        "SMSState": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "Value": true,
        "SMSDetails": {
        "Timestamp": "2017-11-09T07:16:57.427Z",
        "ReceiveTimestamp": "2017-11-09T07:16:57.427Z",
        "SenderNumber": "string",
        "Encoding": "string",
        "Message": "string",
        "ReadStatus": "Full"
        }
        },
        "ICCID": "string",
        "MSISDN": "string",
        "TenantId": "00000000-0000-0000-0000-000000000000",
        "OwnerId": "00000000-0000-0000-0000-000000000000",
        "Id": "00000000-0000-0000-0000-000000000000",
        "CreatedOn": "2017-11-09T07:16:57.427Z",
        "LastModified": "2017-11-09T07:16:57.427Z",
        "Deleted": true,
        "Metadata": {},
        "Links": {}
        }
        """
    }
}
