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

class AppTests: XCTestCase {
    func testAppModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<App>().map(JSONObject: jsonObject)

        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Description, "string")
        XCTAssertEqual(model?.Downloads, 0)
        XCTAssertEqual(model?.OwnerId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.RedirectUris[0], "string")
        XCTAssertNotNil(model?.Image)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-09T07:16:57.039Z")
        XCTAssertEqual(model?.LastModified, "2017-11-09T07:16:57.039Z")
        XCTAssertEqual(model?.Deleted, true)
    }
}

extension AppTests {
    var jsonString: String {
        return """
        {
            "Name": "string",
            "Description": "string",
            "Downloads": 0,
            "OwnerId": "00000000-0000-0000-0000-000000000000",
            "RedirectUris": [
                "string"
            ],
            "Image": {
                "Src": "https://example.test/src-image.png",
                "Normal": "https://example.test/normal-image.png",
                "Thumbnail": "https://example.test/thumb-image.png"
            },
            "Tags": [
                "string"
            ],
            "Id": "00000000-0000-0000-0000-000000000000",
            "CreatedOn": "2017-11-09T07:16:57.039Z",
            "LastModified": "2017-11-09T07:16:57.039Z",
            "Deleted": true,
            "Metadata": {},
            "Links": {}
        }
        """
    }
}
