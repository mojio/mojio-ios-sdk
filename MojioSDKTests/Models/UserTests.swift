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

class UserTests: XCTestCase {
    
    func testUserModelShouldBeCreatedFromJsonString() {
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        let model = Mapper<User>().map(JSONObject: jsonObject)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.FirstName, "string")
        XCTAssertEqual(model?.LastName, "string")
        XCTAssertEqual(model?.UserName, "string")
        XCTAssertEqual(model?.Jurisdiction, "string")
        XCTAssertNotNil(model?.Emails)
        XCTAssertNotNil(model?.PhoneNumbers)
        XCTAssertNotNil(model?.Tags)
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-10T07:07:44.827Z")
        XCTAssertEqual(model?.LastModified, "2017-11-10T07:07:44.827Z")
    }
}

extension UserTests {
    var jsonString: String {
        return """
        {
        "FirstName": "string",
        "DefaultLanguage": "string",
        "LastName": "string",
        "UserName": "string",
        "Jurisdiction": "string",
        "Emails": [
        {
        "Verified": true,
        "Address": "string"
        }
        ],
        "PhoneNumbers": [
        {
        "PhoneNumber": "string",
        "Verified": true
        }
        ],
        "Image": {
        "Src": "string",
        "Normal": "string",
        "Thumbnail": "string"
        },
        "Tags": [
        "string"
        ],
        "OwnerId": "00000000-0000-0000-0000-000000000000",
        "TenantId": "00000000-0000-0000-0000-000000000000",
        "Id": "00000000-0000-0000-0000-000000000000",
        "CreatedOn": "2017-11-10T07:07:44.827Z",
        "LastModified": "2017-11-10T07:07:44.827Z",
        "Deleted": true,
        "Metadata": {},
        "Links": {}
        }
        """
    }
}
