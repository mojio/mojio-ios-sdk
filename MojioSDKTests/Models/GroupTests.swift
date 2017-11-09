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

class GroupTests: XCTestCase {

    var model: Group!
    
    override func setUp() {
        super.setUp()
        
        let jsonString = """
        {
          "Name": "string",
          "Description": "string",
          "OwnerId": "00000000-0000-0000-0000-000000000000",
          "Tags": [
            "string"
          ],
          "Id": "00000000-0000-0000-0000-000000000000",
          "CreatedOn": "2017-11-09T07:15:14.853Z",
          "LastModified": "2017-11-09T07:15:14.853Z",
          "Deleted": true,
          "Metadata": {},
          "Links": {}
        }
        """
        
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        model = Mapper<Group>().map(JSONObject: jsonObject)
    }
    
    func testGroupModelShouldBeCreatedFromJsonString() {
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.Name, "string")
        XCTAssertEqual(model?.Description, "string")
        XCTAssertEqual(model?.OwnerId, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.Tags[0], "string")
        XCTAssertEqual(model?.Id, "00000000-0000-0000-0000-000000000000")
        XCTAssertEqual(model?.CreatedOn, "2017-11-09T07:15:14.853Z")
        XCTAssertEqual(model?.LastModified, "2017-11-09T07:15:14.853Z")
        XCTAssertEqual(model?.Deleted, true)
    }
    
    func testGroupModelShouldReturnJsonString() {
        let json = model.json()
        XCTAssertNotNil(json)
    }
}
