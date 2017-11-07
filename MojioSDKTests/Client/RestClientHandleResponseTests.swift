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

    func testHAndleResponseShouldCallCompletionBlockWithBool() {
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
}
