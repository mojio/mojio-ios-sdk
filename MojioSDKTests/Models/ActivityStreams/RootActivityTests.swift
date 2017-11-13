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

class RootActivityTests: XCTestCase {
    func testRootActivityModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<RootActivity>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.Actor)
        XCTAssertNotNil(model?.Target)
        XCTAssertNotNil(model?.Result)
        XCTAssertNotNil(model?.Object)
        XCTAssertNotNil(model?.Origin)
    }
}

extension RootActivityTests {
    var jsonString: String {
        return """
        {
        "Updated": "string",
        "Content": "string",
        "AttributedTo": {
        "Id": "string"
        },
        "Actor": {
        "HRef": "string",
        "Name": "string",
        "Type": "Person",
        "Id": "00000000-0000-0000-0000-000000000000",
        "Context": "string",
        "SummaryMap": {}
        },
        "Target": {
        "HRef": "string",
        "Name": "string",
        "Type": "Vehicle",
        "Id": "00000000-0000-0000-0000-000000000000"
        },
        "Result": {
        "HRef": "string",
        "Name": "string",
        "Type": "Trip",
        "Id": "00000000-0000-0000-0000-000000000000",
        "EndTime": "2017-10-30T15:23:11.072Z",
        "Location": {
        "Longitude": 0,
        "Latitude": 0,
        "Altitude": 0,
        "Name": "string",
        "Type": "Location"
        },
        "StartTime": "2017-10-30T14:42:41.790Z",
        "Duration": "00:40:29.2820000"
        },
        "Origin": {
        "Name": "string",
        "Type": "Location"
        },
        "Id": "00000000-0000-0000-0000-000000000000",
        "Context": "string",
        "Type": "Arrive",
        "Name": "string",
        "NameMap": {
        "en": "string",
        "cs": "string",
        "fr": "string",
        "de": "string"
        },
        "EndTime": "2017-10-30T15:23:11.072Z",
        "Location": {
        "Longitude": 0,
        "Latitude": 0,
        "Altitude": 0,
        "Name": "string",
        "Type": "Location"
        },
        "Published": "2017-10-30T15:23:12.075Z",
        "StartTime": "2017-10-30T14:42:41.790Z",
        "SummaryMap": {
        "en": "string",
        "cs": "string",
        "fr": "string",
        "de": "string"
        },
        "Duration": "00:40:29.2820000",
        "Object": {
        "Id": "00000000-0000-0000-0000-000000000000"
        }
        }
        """
    }
}
