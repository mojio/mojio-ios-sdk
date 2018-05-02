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

class TripPolylineTests: XCTestCase {
    func testTripPolylineModelShouldBeCreatedFromJsonString() {
        let jsonString = """
        {
        "Polyline": "string",
        "Id": "00000000-0000-0000-0000-000000000000",
        "CreatedOn": "2017-11-10T07:07:42.040Z",
        "LastModified": "2017-11-10T07:07:42.040Z",
        "Deleted": true,
        "Metadata": {},
        "Links": {}
        }
        """
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<TripPolyline>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.TripPolyline, "string")
        XCTAssertEqual(model?.CreatedOn, "2017-11-10T07:07:42.040Z")
        XCTAssertEqual(model?.LastModified, "2017-11-10T07:07:42.040Z")
        XCTAssertEqual(model?.Deleted, true)
    }
}
