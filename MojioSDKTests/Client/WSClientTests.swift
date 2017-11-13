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
import OHHTTPStubs
import XCTest

class WSClientTests: XCTestCase {
    
    var connectExpectation: XCTestExpectation?
    var disconnectExpectation: XCTestExpectation?
    var eventReceivedExpectation: XCTestExpectation?
    var errorReceivedExpectation: XCTestExpectation?
    
    var factory: WebSocketFactoryStub!
    var client: WSClient!
    
    override func setUp() {
        super.setUp()
        
        self.factory = WebSocketFactoryStub(testCase: self)
        self.client = WSClient(clientEnvironment: ClientEnvironment(), publicKeys: nil, webSocketFactory: self.factory)
        self.client.requestEntity = .vehicles
    }

    func testWSClientShouldCallWebSocketConnect() {
        connectExpectation = expectation(description: "web socket connect function called")
        
        _ = client.watch(next: { _ in }, completion: { }, failure: { _ in })
        
        wait(for: [connectExpectation!], timeout: 1)
    }
    
    func testWSClientShouldReceiveEventsWithData() {
        let jsonString =
"""
{"Name":"string"}
"""
        eventReceivedExpectation = expectation(description: "web socket received an event with the data")

        var receivedVehicle: Vehicle? = nil
        
        let webSocket = client.watch(next: { data in
            receivedVehicle = data as? Vehicle
            self.eventReceivedExpectation?.fulfill()
        }, completion: {
            self.eventReceivedExpectation?.fulfill()
        }, failure: { _ in
            self.eventReceivedExpectation?.fulfill()
        }) as! WebSocketProviderMock
        
        webSocket.sendMessage(with: jsonString)
        
        wait(for: [eventReceivedExpectation!], timeout: 1)
        
        XCTAssertNotNil(receivedVehicle)
        XCTAssertEqual(receivedVehicle?.Name, "string")
    }
    
    func testWSClientShouldCallFailureBlockWhenErrorIsReceived() {
        errorReceivedExpectation = expectation(description: "web socket received an error")
        
        var receivedError: Error? = nil
        
        let webSocket = client.watch(next: { _ in
            self.errorReceivedExpectation?.fulfill()
        }, completion: {
            self.errorReceivedExpectation?.fulfill()
        }, failure: { error in
            receivedError = error
            self.errorReceivedExpectation?.fulfill()
        }) as! WebSocketProviderMock
        
        webSocket.sendError(Errors.responseError)
        
        wait(for: [errorReceivedExpectation!], timeout: 1)
        
        XCTAssertNotNil(receivedError)
    }
    
    func testWSClientShouldCallCompletionBlickOnDisconnect() {
        let disconnectExpectation = expectation(description: "web socket disconnected")
        
        var disconnected: Bool = false
        
        let webSocket = client.watch(next: { _ in
            disconnectExpectation.fulfill()
        }, completion: {
            disconnected = true
            disconnectExpectation.fulfill()
        }, failure: { _ in
            disconnectExpectation.fulfill()
        }) as! WebSocketProviderMock
        
        webSocket.sendDisconnect()
        
        wait(for: [disconnectExpectation], timeout: 1)
        
        XCTAssertTrue(disconnected)
    }
}

extension WSClientTests {
    class WebSocketFactoryStub: WebSocketFactory {
        var pinnedPublicKeys: [SecKey]? = nil
        var callbackQueue: DispatchQueue? = nil
        let testCase: WSClientTests
        
        init(testCase: WSClientTests) {
            self.testCase = testCase
        }
        
        func create(request: URLRequest) -> WebSocketProvider {
            return WebSocketProviderMock(testCase: self.testCase)
        }
    }
    
    class WebSocketProviderMock: WebSocketProvider {
        let testCase: WSClientTests
        var onConnect: () -> Void = { }
        var onDisconnect: (Error?) -> Void = { _ in }
        var onMessage: (Any) -> Void = { _ in }
        var onPong: (Any) -> Void = { _ in }
        
        required init(request: URLRequest) {
            fatalError("This init shouldn't be used")
        }
        
        required init(testCase: WSClientTests) {
            self.testCase = testCase
        }
        
        func connect() {
            self.testCase.connectExpectation?.fulfill()
        }
        
        func disconnect() {
            self.testCase.disconnectExpectation?.fulfill()
        }
        
        func sendMessage(with data: Any) {
            onMessage(data)
        }
        
        func sendError(_ error: Error) {
            onDisconnect(error)
        }

        func sendDisconnect() {
            onDisconnect(nil)
        }
    }
}
