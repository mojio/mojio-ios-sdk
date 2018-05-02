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

class MojioTests: XCTestCase {
    
    func testMojioModelShouldBeCreatedFromJson() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<Mojio>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.IMEI, "string")
        XCTAssertEqual(model?.LastContactTime, "2017-11-09T07:16:57.426Z")
        XCTAssertEqual(model?.GatewayTime, "2017-11-09T07:16:57.426Z")
        XCTAssertEqual(model?.VehicleId, "00000000-0000-0000-0000-000000000000")
        XCTAssertNotNil(model?.MojioLocation)
        XCTAssertEqual(model?.Tags[0], "string")
        XCTAssertNotNil(model?.Wifi)
        XCTAssertNotNil(model?.ConnectedState)
        XCTAssertEqual(model?.CreatedOn, "2017-11-09T07:16:57.427Z")
        XCTAssertEqual(model?.LastModified, "2017-11-09T07:16:57.427Z")
        XCTAssertEqual(model?.Deleted, true)
        XCTAssertEqual(model?.MSISDN, "string")
        XCTAssertEqual(model?.ICCID, "string")
    }
    
    func testMojioShouldCreateJsonString() {
        let sampleJson = """
{"Name":"name","IMEI":"imei"}
"""
        var mojio = Mojio()
        mojio.Name = "name"
        mojio.IMEI = "imei"
        
        let json = mojio.json()
        
        XCTAssertEqual(json, sampleJson)
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
        "timestamp": "2017-11-09T07:16:57.426Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-09T07:16:57.426Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-09T07:16:57.426Z",
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
        "Tags": [
        "string"
        ],
        "WifiRadio": {
        "timestamp": "2017-11-09T07:16:57.427Z",
        "SSID": "string",
        "Password": "string",
        "AllowRoaming": true,
        "Status": "Unknown",
        "Strength": 0
        },
        "GPSRadio": {
        "timestamp": "2017-11-09T07:16:57.427Z",
        "NumberOfSattelitesForPositionFix": 0,
        "PDOP": 0,
        "HorizontalDilutionOfPrecision": 0,
        "VDOP": 0,
        "Location": {
        "timestamp": "2017-11-09T07:16:57.427Z",
        "Lat": 0,
        "Lng": 0,
        "Status": "Unknown",
        "Dilution": 0,
        "Altitude": 0,
        "GeoHash": "string",
        "Accuracy": {
        "baseUnit": "Meters",
        "timestamp": "2017-11-09T07:16:57.427Z",
        "baseValue": 0,
        "unit": "Meters",
        "value": 0
        },
        "Heading": {
        "baseUnit": "Degree",
        "Direction": "string",
        "LeftTurn": true,
        "timestamp": "2017-11-09T07:16:57.427Z",
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
        "HardwareAccuracyInMeters": 0,
        "PercentLostGPS": 0,
        "PercentLostGPSQ": 0,
        "Status": "Unknown",
        "Source": "GPS",
        "LostLockTime": {
        "baseUnit": "Ticks",
        "timestamp": "2017-11-09T07:16:57.427Z",
        "baseValue": 0,
        "unit": "Ticks",
        "value": 0
        },
        "Speed": {
        "baseUnit": "KilometersPerHour",
        "timestamp": "2017-11-09T07:16:57.427Z",
        "baseValue": 0,
        "unit": "KilometersPerHour",
        "value": 0
        }
        },
        "ConnectedState": {
        "timestamp": "2017-11-09T07:16:57.427Z",
        "value": true
        },
        "SMSState": {
        "timestamp": "2017-11-09T07:16:57.427Z",
        "value": true,
        "SMSDetails": {
        "timestamp": "2017-11-09T07:16:57.427Z",
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
