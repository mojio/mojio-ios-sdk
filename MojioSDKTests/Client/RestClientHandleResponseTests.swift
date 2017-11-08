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
import Alamofire
import OHHTTPStubs

class RestClientHandleResponseTests: XCTestCase {
    var client: RestClient!
    var response: HTTPURLResponse!
    var url: URL!
    
    override func setUp() {
        super.setUp()

        self.client = RestClient(clientEnvironment: ClientEnvironment())
        self.url = URL(string: self.client.requestUrl!)!
        self.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
    }
    
    func testHandleResponseShouldCallFailureBlockIfResponseStatusCodeNotOK() {
        let result = Alamofire.Result<Any>.failure(Errors.responseError)
        let notOKResponse = HTTPURLResponse(url: self.url, statusCode: 400, httpVersion: nil, headerFields: nil)
        let response = DataResponse(request: nil, response: notOKResponse, data: nil, result: result)
        var responseResult: Any? = nil
        let e = expectation(description: "")
        
        self.client.handleResponse(response, completion: { _ in
            e.fulfill()
        }) { error in
            responseResult = error
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult as? String, "Could not complete request")
    }
    
    func testHandleResponseShouldCallFailureBlockIfResponseStatusCodeIsNotOKAndResponseHasData() {
        let result = Alamofire.Result<Any>.success(["Error": "ResponseError"])
        let notOKResponse = HTTPURLResponse(url: self.url, statusCode: 400, httpVersion: nil, headerFields: nil)
        let response = DataResponse(request: nil, response: notOKResponse, data: nil, result: result)
        var responseResult: NSDictionary? = nil
        let e = expectation(description: "")
        
        self.client.handleResponse(response, completion: { _ in
            e.fulfill()
        }) { error in
            responseResult = error as? NSDictionary
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult?["Error"] as? String, "ResponseError")
    }
    
    func testHAndleResponseShouldCallCompletionBlockWithString() {
        let result = Alamofire.Result<Any>.success("Success")
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: String? = nil
        let e = expectation(description: "")

        self.client.handleResponse(response, completion: { result in
            responseResult = result as? String
            e.fulfill()
        }) { _ in
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult, "Success")
    }

    func testHandleResponseShouldCallCompletionBlockWithBool() {
        let result = Alamofire.Result<Any>.success(true)
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: Bool? = nil
        let e = expectation(description: "")
        
        self.client.handleResponse(response, completion: { result in
            responseResult = result as? Bool
            e.fulfill()
        }) { _ in
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult, true)
    }
    
    func testHandleResponseShouldCallCompletionBlockWithResult() {
        let json: [String: Any] = [
            "Data": [
                ["Id": "111111111"],
                ["Id": "222222222"]
            ],
            "TotalCount": 2
        ]
        let result = Alamofire.Result<Any>.success(json)
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: MojioSDK.Result? = nil
        let e = expectation(description: "")

        self.client.requestParams = ["includeCount": "true" as AnyObject]
        self.client.requestEntity = .users
        self.client.handleResponse(response, completion: { result in
            responseResult = result as? MojioSDK.Result
            e.fulfill()
        }) { _ in
            e.fulfill()
        }

        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult?.Data?.count, 2)
    }
    
    func testHandleResponseShouldCallCompletionBlockWithArray() {
        let json: [String: Any] = [
            "Data": [
                ["Id": "111111111"],
                ["Id": "222222222"]
            ]
        ]
        let result = Alamofire.Result<Any>.success(json)
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: [User]? = nil
        let e = expectation(description: "")
        
        self.client.requestEntity = .users
        self.client.handleResponse(response, completion: { result in
            responseResult = result as? [User]
            e.fulfill()
        }) { _ in
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult?.count, 2)
    }
    
    func testHandleResponseShouldCallCompletionBlockWithMessage() {
        let message = "message text"
        let json: [String: Any] = [
            "Message": message
        ]
        let result = Alamofire.Result<Any>.success(json)
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: String? = nil
        let e = expectation(description: "")
        
        self.client.handleResponse(response, completion: { result in
            responseResult = result as? String
            e.fulfill()
        }) { _ in
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult, message)
    }
    
    func testHandleResponseShouldCallCompletionBlockWithSingleEntity() {
        let id = "1111111111"
        let json: [String: Any] = [
            "Id": id
        ]
        let result = Alamofire.Result<Any>.success(json)
        let response = DataResponse(request: nil, response: self.response, data: nil, result: result)
        
        var responseResult: User? = nil
        let e = expectation(description: "")
        
        self.client.requestEntity = .users
        self.client.handleResponse(response, completion: { result in
            responseResult = result as? User
            e.fulfill()
        }) { _ in
            e.fulfill()
        }
        
        wait(for: [e], timeout: 1)
        
        XCTAssertNotNil(responseResult)
        XCTAssertEqual(responseResult?.Id, id)
        
    }
}
