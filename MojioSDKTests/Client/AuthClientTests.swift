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
import ObjectMapper
import OHHTTPStubs

class AuthClientTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()

        super.tearDown()
    }
    
    func testAuthTokenParsing() {
        let json = """
{
    "accessToken": "mF_9.B5f-4.1JqM",
    "uniqueId": "123456",
    "expiry": "5600",
    "refreshToken": "tGzv3JOkF0XG5Qx2TlKWIA"
}
"""
        let jsonObject = try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: .allowFragments)
        let authToken = Mapper<AuthToken>().map(JSONObject: jsonObject)
        
        XCTAssertEqual(authToken?.accessToken, "mF_9.B5f-4.1JqM")
        XCTAssertEqual(authToken?.expiry, "5600")
        XCTAssertEqual(authToken?.uniqueId, "123456")
        XCTAssertEqual(authToken?.refreshToken, "tGzv3JOkF0XG5Qx2TlKWIA")
    }
    
    func testAuthTokenCorrectExpiryTimestamp() {
        let authToken = AuthToken(accessToken: nil, expiry: "3600", refreshToken: nil, uniqueId: nil)
        let expiryTimestamp = authToken.expiryTimestamp()
        XCTAssertEqual(expiryTimestamp, 3600)
    }
    
    func testAuthTokenBadExpiryTimestamp() {
        let authToken = AuthToken(accessToken: nil, expiry: "bad timestamp", refreshToken: nil, uniqueId: nil)
        let expiryTimestamp = authToken.expiryTimestamp()
        XCTAssertNil(expiryTimestamp)
    }
    
    func testAuthTokenCorrectExpiryDate() {
        let authToken = AuthToken(accessToken: nil, expiry: "3600", refreshToken: nil, uniqueId: nil)
        let expiryDate = authToken.expiryDate()
        XCTAssertEqual(expiryDate, Date(timeIntervalSince1970: 3600))
    }

    func testAuthTokenBadExpiryDate() {
        let authToken = AuthToken(accessToken: nil, expiry: "bad timestamp", refreshToken: nil, uniqueId: nil)
        let expiryDate = authToken.expiryDate()
        XCTAssertNil(expiryDate)
    }
    
    func testAuthTokenIsValid() {
        let timestamp = String(Date().timeIntervalSince1970 + 3600)
        let authToken = AuthToken(accessToken: "access_token", expiry: timestamp, refreshToken: "refresh_token", uniqueId: "unique_id")
        
        let isValid = authToken.isValid()
        
        XCTAssertTrue(isValid)
    }
    
    func testAuthTokenIsInvalid() {
        let expiredTimestamp = String(Date().timeIntervalSince1970 - 3600)
        
        let tokenWithNilProperties = AuthToken(accessToken: nil, expiry: nil, refreshToken: nil, uniqueId: nil)
        let tokenWithBadExpiryTimestamp = AuthToken(accessToken: "access_token", expiry: "bad timestamp", refreshToken: "refresh_token", uniqueId: "unique_id")
        let expiredToken = AuthToken(accessToken: "access_token", expiry: expiredTimestamp, refreshToken: "refresh_token", uniqueId: "unique_id")
        
        let firstCaseResult = tokenWithNilProperties.isValid()
        let secondCaseResult = tokenWithBadExpiryTimestamp.isValid()
        let thirdCaseResult = expiredToken.isValid()
        
        XCTAssertFalse(firstCaseResult)
        XCTAssertFalse(secondCaseResult)
        XCTAssertFalse(thirdCaseResult)
    }
    
    func testAuthClientShoulSaveAndGetAuthToken() {
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: "3600", refreshToken: "refresh_token", uniqueId: "unique_id")
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)

        client.saveAuthToken(sampleToken)
        let token = client.getAuthToken()
        
        XCTAssertEqual(sampleToken.accessToken, token.accessToken)
        XCTAssertEqual(sampleToken.refreshToken, token.refreshToken)
        XCTAssertEqual(sampleToken.uniqueId, token.uniqueId)
        XCTAssertEqual(sampleToken.expiry, token.expiry)
    }
    
    func testAuthClientGetTokenUrl() {
        let region = MojioRegionStub(.develop, prefix: "us-")
        let env = ClientEnvironment()
        env.setRegion(region)
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        let url = client.getTokenUrl()
        
        XCTAssertEqual(url, "https://us-develop-identity.moj.io/oauth2/token")
    }
    
    func testAuthClientGetTokenUrlWithParams() {
        let region = MojioRegionStub(.develop, prefix: "us-")
        let env = ClientEnvironment()
        env.setRegion(region)
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        let url = client.getTokenUrl(client.clientRedirectURL, clientId: client.clientId)
        
        XCTAssertEqual(url, "https://us-develop-identity.moj.io/oauth2/token?response_type=token&redirect_uri=redirect-url&client_id=client-id&scope=full")
    }

    func testAuthClientGetAuthUrl() {
        let region = MojioRegionStub(.develop, prefix: "us-")
        let env = ClientEnvironment()
        env.setRegion(region)
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        let url = client.getAuthorizeUrl()
        
        XCTAssertEqual(url, "https://us-develop-identity.moj.io/oauth2/authorize")
    }
    
    func testAuthClientGetAuthUrlWithParams() {
        let region = MojioRegionStub(.develop, prefix: "us-")
        let env = ClientEnvironment()
        env.setRegion(region)
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        let url = client.getAuthorizeUrl(client.clientRedirectURL, clientId: client.clientId)
        
        XCTAssertEqual(url, "https://us-develop-identity.moj.io/oauth2/authorize?response_type=token&redirect_uri=redirect-url&client_id=client-id&scope=full")
    }
    
    func testAuthClientCheckIfUserIsLoggedIn() {
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let expiryTimestamp = String(Date().timeIntervalSince1970 + 3600)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: expiryTimestamp, refreshToken: "refresh_token", uniqueId: "")
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        
        client.saveAuthToken(sampleToken)
        let isUserLoggedIn = client.isUserLoggedIn()
        
        XCTAssertTrue(isUserLoggedIn)
    }
    
    func testAuthClientCheckIfUserIsLoggedInWithSomeRegion() {
        let regionType = MojioRegion.RegionType.develop
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let expiryTimestamp = String(Date().timeIntervalSince1970 + 3600)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: expiryTimestamp, refreshToken: "refresh_token", uniqueId: regionType.rawValue)
        let env = ClientEnvironment()
        let region = MojioRegion(regionType)
        env.setRegion(region)
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        client.saveAuthToken(sampleToken)

        let isUserLoggedIn = client.isUserLoggedIn()
        
        XCTAssertTrue(isUserLoggedIn)
    }
    
    func testIsUserLoggedShouldReturnFalseIfAuthTokenIsEmpty() {
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        let loggedIn = client.isUserLoggedIn()
        
        XCTAssertFalse(loggedIn)
    }
    
    func testIsUserLoggedInShouldReturnFalseIfAuthTokenRegionNotEqualToClientEnvRegion() {
        let regionType = MojioRegion.RegionType.develop
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let expiryTimestamp = String(Date().timeIntervalSince1970 + 3600)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: expiryTimestamp, refreshToken: "refresh_token", uniqueId: regionType.rawValue)
        keychainManager.saveAuthToken(sampleToken)

        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        
        let loggedIn = client.isUserLoggedIn()
        
        XCTAssertFalse(loggedIn)
    }
    
    func testIsUserLoggedInShouldReturnFalseIfExpiryPropertyIsInvalid() {
        let regionType = MojioRegion.RegionType.production
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: "invalid", refreshToken: "refresh_token", uniqueId: regionType.rawValue)
        keychainManager.saveAuthToken(sampleToken)
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        
        let loggedIn = client.isUserLoggedIn()
        
        XCTAssertFalse(loggedIn)
    }
    
    func testIsUserLoggedInShouldReturnFalseIfUserTokenIsExpired() {
        let regionType = MojioRegion.RegionType.production
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: String(Date().timeIntervalSince1970 - 3600), refreshToken: "refresh_token", uniqueId: regionType.rawValue)
        keychainManager.saveAuthToken(sampleToken)
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        
        let loggedIn = client.isUserLoggedIn()
        
        XCTAssertFalse(loggedIn)
    }
    
    func testLogout() {
        let storage = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: storage)
        let sampleToken = AuthToken(accessToken: "access_token", expiry: "3600", refreshToken: "refresh_token", uniqueId: "")
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url", keychainManager: keychainManager)
        client.saveAuthToken(sampleToken)
        
        client.logout()
        let token = keychainManager.getAuthToken()

        XCTAssertNil(token.accessToken)
        XCTAssertNil(token.refreshToken)
        XCTAssertNil(token.expiry)
        XCTAssertNil(token.uniqueId)
    }
    
    func testResetPasswordWithStatusCode200() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.reset.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "OK"], statusCode: 200, headers: nil)
        }

        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "reset password request complete with status code 200.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.resetPassword("reset-token", password: "my-strong-password", completion: { result in
            successfulResult = result
            requestExpectation.fulfill()
        }) { result in
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)

        XCTAssertNotNil(successfulResult)
        XCTAssertEqual(successfulResult?["Status"] as? String, "OK")
    }

    func testResetPasswordWithStatusCodeNotEqual200() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.reset.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "Error"], statusCode: 404, headers: nil)
        }
        
        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "reset password request complete with status code != 200.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.resetPassword("reset-token", password: "my-strong-password", completion: { result in
            requestExpectation.fulfill()
        }) { result in
            successfulResult = result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNotNil(successfulResult)
        XCTAssertEqual(successfulResult?["Status"] as? String, "Error")
    }


    func testResetPasswordWithError() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.reset.rawValue)
        ) { request in
            return OHHTTPStubsResponse(error: Errors.responseError)
        }
        
        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "reset password request complete with error.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.resetPassword("reset-token", password: "my-strong-password", completion: { result in
            requestExpectation.fulfill()
        }) { result in
            successfulResult = result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNil(successfulResult)
    }
    
    func testForgotPasswordWithStatusCode200() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.forgot.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "OK"], statusCode: 200, headers: nil)
        }

        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "password password request complete with status code 200.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.forgotPassword("tast@example.com", completion: { result in
            successfulResult = result
            requestExpectation.fulfill()
        }) { result in
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNotNil(successfulResult)
        XCTAssertEqual(successfulResult?["Status"] as? String, "OK")
    }
    
    func testForgotPasswordWithStatusCodeNotEqual200() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.forgot.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "Error"], statusCode: 404, headers: nil)
        }
        
        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "forgot password request complete with status code != 200.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.forgotPassword("tast@example.com", completion: { result in
            requestExpectation.fulfill()
        }) { result in
            successfulResult = result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNotNil(successfulResult)
        XCTAssertEqual(successfulResult?["Status"] as? String, "Error")
    }
    
    
    func testForgotPasswordWithError() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.forgot.rawValue)
        ) { request in
            return OHHTTPStubsResponse(error: Errors.responseError)
        }
        
        var successfulResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "forgot password request completed with error.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        client.forgotPassword("tast@example.com", completion: { result in
            requestExpectation.fulfill()
        }) { result in
            successfulResult = result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNil(successfulResult)
    }

    func testResendPhonePinWasSuccessful() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.resendPin.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "OK"], statusCode: 200, headers: nil)
        }
        
        var successfulResult = false
        let requestExpectation = expectation(description: "resend phone pin request completed with success.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        client.resendPhonePin("mobyle-phone-number", completion: {
            successfulResult = true
            requestExpectation.fulfill()
        }) {
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertTrue(successfulResult)
    }

    func testResendPhonePinWasFailed() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.resendPin.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "Failed"], statusCode: 400, headers: nil)
        }
        
        var requestFailed = false
        let requestExpectation = expectation(description: "resend phone pin request completed with error.")
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        
        client.resendPhonePin("mobile-phone-number", completion: {
            requestExpectation.fulfill()
        }) {
            requestFailed = true
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertTrue(requestFailed)
    }
    
    func testAuthClientShouldVerifyMobilePhone() {
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let expirationTimestamp = Date().timeIntervalSince1970 + 3600
        let responseJson: [String: Any] = [
            "expires_in": expirationTimestamp,
            "access_token": accessToken,
            "refresh_token": refreshToken
        ]
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var receivedToken: AuthToken? = nil
        let requestExpectation = expectation(description: "request should complete")
        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            receivedToken = authToken
            requestExpectation.fulfill()
        }) { result in
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertNotNil(receivedToken)
        XCTAssertEqual(receivedToken?.accessToken, accessToken)
        XCTAssertEqual(receivedToken?.refreshToken, refreshToken)
//        XCTAssertEqual(receivedToken?.expiryTimestamp(), expirationTimestamp)
    }
    
    func testAuthClientShouldCallFailureBlockWithResultIfStatusCodeNotOK() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: ["Status": "Error"], statusCode: 401, headers: nil)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var requestResult: [String: Any]? = nil
        let requestExpectation = expectation(description: "request should call failure block")

        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            requestExpectation.fulfill()
        }) { result in
            requestResult = result
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)

        XCTAssertNotNil(requestResult)
        XCTAssertEqual(requestResult?["Status"] as? String, "Error")
    }

    func testAuthClientShouldCallFailureBlockIfThereWasRequestError() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(error: Errors.responseError)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var requestFailure = false
        let requestExpectation = expectation(description: "request should call failure block")
        
        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            requestExpectation.fulfill()
        }) { result in
            requestFailure = true
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)

        XCTAssertTrue(requestFailure)
    }
    
    func testAuthClientShouldCallFailureBlockIfAuthTokenIsInvalid() {
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let expirationTimestamp = -Date().timeIntervalSince1970
        let responseJson: [String: Any] = [
            "expires_in": expirationTimestamp,
            "access_token": accessToken,
            "refresh_token": refreshToken
        ]
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var requestFailure = false
        let requestExpectation = expectation(description: "request should call failure block")
        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            requestExpectation.fulfill()
        }) { result in
            requestFailure = true
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertTrue(requestFailure)
    }
    
    func testAuthClientShouldCallFailureBlockIfResponseIsEmpty() {
        let env = ClientEnvironment()
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: [], statusCode: 200, headers: nil)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var requestFailure = false
        let requestExpectation = expectation(description: "request should call failure block")
        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            requestExpectation.fulfill()
        }) { result in
            requestFailure = true
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertTrue(requestFailure)

    }
    
    func testAuthClientShouldCallFailureBlockIfExpiresPropertyIsMissingInResponse() {
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let responseJson: [String: Any] = [
            "access_token": accessToken,
            "refresh_token": refreshToken
        ]
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }
        let client = AuthClient(clientEnvironment: env, clientId: "client-id", clientSecretKey: "secret-key", clientRedirectURI: "redirect-url")
        var requestFailure = false
        let requestExpectation = expectation(description: "request should call failure block")
        client.verifyMobilePhone("mobile=phone-number", pin: "pin", completion: { authToken in
            requestExpectation.fulfill()
        }) { result in
            requestFailure = true
            requestExpectation.fulfill()
        }
        
        wait(for: [requestExpectation], timeout: 1)
        
        XCTAssertTrue(requestFailure)

    }
    
    func testAuthClientShouldCallCompletionBlockIfUserRegistrationWasSuccessful() {
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let responseJson: [String: Any] = [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "expires_in": 3600
        ]
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.register.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: [], statusCode: 200, headers: nil)
        }
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }

        var authTokenFromResponse: AuthToken? = nil
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "")
        
        let responseExpectation = expectation(description: "a response should contain an auth token")
        client.register("+380505987220", email: "test@example.com", password: "strong-password", completion: { authToken in
            authTokenFromResponse = authToken
            responseExpectation.fulfill()
        }) { _ in
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertEqual(authTokenFromResponse?.accessToken, accessToken)
        XCTAssertEqual(authTokenFromResponse?.refreshToken, refreshToken)
    }
    
    func testAuthClientShouldCallFailureBlockWhenLoginAfterRegisterWasFailed() {
        let env = ClientEnvironment()

        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.register.rawValue)
        ) { request in
            return OHHTTPStubsResponse(jsonObject: [], statusCode: 200, headers: nil)
        }
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(error: Errors.responseError)
        }
        
        var responseFailed = false
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "")
        
        let responseExpectation = expectation(description: "a response should fail")
        client.register("+380505987220", email: "test@example.com", password: "strong-password", completion: { authToken in
            responseExpectation.fulfill()
        }) { _ in
            responseFailed = true
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertTrue(responseFailed)
    }
    
    func testAuthClientShouldCallFailureBlockAfterRegistrationWasFailed() {
        let env = ClientEnvironment()
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AccountClientEndpoint.register.rawValue)
        ) { request in
            return OHHTTPStubsResponse(error: Errors.responseError)
        }
        
        var responseFailed = false
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "")
        
        let responseExpectation = expectation(description: "a response should fail")
        client.register("+380505987220", email: "test@example.com", password: "strong-password", completion: { authToken in
            responseExpectation.fulfill()
        }) { _ in
            responseFailed = true
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertTrue(responseFailed)
    }
    
    func testAuthClientShouldCallFailureBlockIfKeychainHasNoToken() {
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "")
        
        var responseFailed = false
        let responseExpectation = expectation(description: "token refresh failed")
        client.refreshAuthToken({ token in
            responseExpectation.fulfill()
        }) { _ in
            responseFailed = true
            responseExpectation.fulfill()
        }
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertTrue(responseFailed)
    }
    
    func testAuthClientShouldCallCompletionBlockAfterRefreshAuthTokenWasSuccessful() {
        let keychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychainStorageProvider)
        let sampleAuthToken = AuthToken(accessToken: "old-access-token", expiry: "4800", refreshToken: "old-refresh-token", uniqueId: "old-id")
        keychainManager.saveAuthToken(sampleAuthToken)
        
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let expireTimestamp: TimeInterval = 3600
        let responseJson: [String: Any] = [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "expires_in": expireTimestamp
        ]

        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }

        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "", keychainManager: keychainManager)
        var tokenFromResponse: AuthToken? = nil
        let responseExpectation = expectation(description: "token refresh was successful")
        client.refreshAuthToken({ token in
            tokenFromResponse = token
            responseExpectation.fulfill()
        }) { _ in
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertNotNil(tokenFromResponse)
        XCTAssertEqual(tokenFromResponse?.accessToken, accessToken)
        XCTAssertEqual(tokenFromResponse?.refreshToken, refreshToken)
    }
    
    func testAuthClientShouldCallFAilureBlockIfJsonIsNotDictionary() {
        let keychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychainStorageProvider)
        let sampleAuthToken = AuthToken(accessToken: "old-access-token", expiry: "4800", refreshToken: "old-refresh-token", uniqueId: "old-id")
        keychainManager.saveAuthToken(sampleAuthToken)

        let env = ClientEnvironment()
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: [], statusCode: 200, headers: nil)
        }
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "", keychainManager: keychainManager)
        var responseFailed = false
        var responseResult: [String: Any]? = nil
        let responseExpectation = expectation(description: "token refresh failed")
        client.refreshAuthToken({ token in
            responseExpectation.fulfill()
        }) { response in
            responseFailed = true
            responseResult = response
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertTrue(responseFailed)
        XCTAssertEqual(responseResult?["Error"] as? String, "WrongResponseFormat")
    }
    
    func testAuthClientRefreshTokenShouldCallFailureBlockIfAuthTokenIsInvalid() {
        let keychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychainStorageProvider)
        let sampleAuthToken = AuthToken(accessToken: "old-access-token", expiry: "4800", refreshToken: "old-refresh-token", uniqueId: "old-id")
        keychainManager.saveAuthToken(sampleAuthToken)
        
        let env = ClientEnvironment()
        let accessToken = "long-access-token-string"
        let refreshToken = "refresh-token-string"
        let expireTimestamp: TimeInterval = -Date().timeIntervalSince1970
        let responseJson: [String: Any] = [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "expires_in": expireTimestamp
        ]

        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: responseJson, statusCode: 200, headers: nil)
        }
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "", keychainManager: keychainManager)
        var responseResult: [String: Any]? = nil
        let responseExpectation = expectation(description: "token refresh failed")
        client.refreshAuthToken({ token in
            responseExpectation.fulfill()
        }) { response in
            responseResult = response
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertEqual(responseResult?["Error"] as? String, "InvalidAuthToken")
    }
    
    func testAuthClientShiuldCallFailureBlockIfStatusCodeIsNot200() {
        let keychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychainStorageProvider)
        let sampleAuthToken = AuthToken(accessToken: "old-access-token", expiry: "4800", refreshToken: "old-refresh-token", uniqueId: "old-id")
        keychainManager.saveAuthToken(sampleAuthToken)
        
        let env = ClientEnvironment()
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
            isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: ["Error": "StatusCodeIsNot200"], statusCode: 404, headers: nil)
        }
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "", keychainManager: keychainManager)
        var responseResult: [String: Any]? = nil
        let responseExpectation = expectation(description: "token refresh failed")
        client.refreshAuthToken({ token in
            responseExpectation.fulfill()
        }) { response in
            responseResult = response
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertEqual(responseResult?["Error"] as? String, "StatusCodeIsNot200")

    }
    
    func testAuthClientShouldCallFailureBlockIfExpiryFieldIsMissing() {
        let keychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychainStorageProvider)
        let sampleAuthToken = AuthToken(accessToken: "old-access-token", expiry: "4800", refreshToken: "old-refresh-token", uniqueId: "old-id")
        keychainManager.saveAuthToken(sampleAuthToken)
        
        let env = ClientEnvironment()
        
        stub(condition:
            isHost(env.domainFromMojioEndpoint(.identity)) &&
                isPath("/" + AuthClientEndpoint.token.rawValue)
        ) { _ in
            return OHHTTPStubsResponse(jsonObject: ["refresh_token": "*", "access_token": "*"], statusCode: 200, headers: nil)
        }
        
        let client = AuthClient(clientEnvironment: ClientEnvironment(), clientId: "", clientSecretKey: "", clientRedirectURI: "", keychainManager: keychainManager)
        var responseResult: [String: Any]? = nil
        let responseExpectation = expectation(description: "token refresh failed")
        client.refreshAuthToken({ token in
            responseExpectation.fulfill()
        }) { response in
            responseResult = response
            responseExpectation.fulfill()
        }
        
        wait(for: [responseExpectation], timeout: 1)
        
        XCTAssertEqual(responseResult?["Error"] as? String, "ExpiryFieldIsMissing")
    }

}
