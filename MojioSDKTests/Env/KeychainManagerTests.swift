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
import KeychainSwift

class KeychainManagerTests: XCTestCase {
    var sampleAuthToken: AuthToken!

    func testSaveAuthToken() {
        let authToken = AuthToken(accessToken: "accessToken", expiry: "extipationDate", refreshToken: "refreshToken", uniqueId: "uniqueId")
        let keychain: KeychainStorageProvider = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychain)
        
        keychainManager.saveAuthToken(authToken)
        
        XCTAssertEqual(keychain.get(by: KeychainKey.accessToken.rawValue), authToken.accessToken)
        XCTAssertEqual(keychain.get(by: KeychainKey.accessTokenExpiry.rawValue), authToken.expiry)
        XCTAssertEqual(keychain.get(by: KeychainKey.refreshToken.rawValue), authToken.refreshToken)
        XCTAssertEqual(keychain.get(by: KeychainKey.uniqueId.rawValue), authToken.uniqueId)
    }
    
    func testGetAuthToken() {
        let sampleAuthToken = AuthToken(accessToken: "accessToken", expiry: "extipationDate", refreshToken: "refreshToken", uniqueId: "uniqueId")
        let keychainManager = KeychainManager(keychain: KeychainStorageProviderMock())

        keychainManager.saveAuthToken(sampleAuthToken)
        let authToken = keychainManager.getAuthToken()
        
        XCTAssertEqual(sampleAuthToken.accessToken, authToken.accessToken)
        XCTAssertEqual(sampleAuthToken.expiry, authToken.expiry)
        XCTAssertEqual(sampleAuthToken.refreshToken, authToken.refreshToken)
        XCTAssertEqual(sampleAuthToken.uniqueId, authToken.uniqueId)
    }
    
    func testDeleteTokenFromKeychain() {
        let authToken = AuthToken(accessToken: "accessToken", expiry: "extipationDate", refreshToken: "refreshToken", uniqueId: "uniqueId")
        let keychain = KeychainStorageProviderMock()
        let keychainManager = KeychainManager(keychain: keychain)
        
        keychainManager.saveAuthToken(authToken)
        keychainManager.deleteTokenFromKeychain()
        
        XCTAssertNil(keychain.get(by: KeychainKey.accessToken.rawValue))
        XCTAssertNil(keychain.get(by: KeychainKey.accessTokenExpiry.rawValue))
        XCTAssertNil(keychain.get(by: KeychainKey.refreshToken.rawValue))
        XCTAssertNil(keychain.get(by: KeychainKey.uniqueId.rawValue))
    }
    
    class KeychainStorageProviderMock: KeychainStorageProvider {
        private var storage = [String: String]()

        func get(by key: String) -> String? {
            return storage[key]
        }
        
        func set(value: String, for key: String) {
            storage[key] = value
        }
        
        func delete(by key: String) {
            storage[key] = nil
        }
        
        func clear() {
            storage = [:]
        }
    }
}
