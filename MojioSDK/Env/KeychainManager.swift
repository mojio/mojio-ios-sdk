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

import UIKit
import KeychainSwift

public enum KeychainKey: String {
    case accessToken = "MojioSDKAccessToken"
    case refreshToken = "MojioSDKRefreshToken"
    case accessTokenExpiry = "MojioSDKAccessTokenExpiry"
    case uniqueId = "MojioSDKUniqueId"
}

open class KeychainManager {
    
    let keychain: KeychainStorageProvider
    
    public init(keychain: KeychainStorageProvider = KeychainSwift()) {
        self.keychain = keychain
    }
    
    open func getAuthToken() -> AuthToken {
        return AuthToken(
            accessToken: self.keychain.get(by: KeychainKey.accessToken.rawValue),
            expiry: self.keychain.get(by: KeychainKey.accessTokenExpiry.rawValue),
            refreshToken: self.keychain.get(by: KeychainKey.refreshToken.rawValue),
            uniqueId: self.keychain.get(by: KeychainKey.uniqueId.rawValue)
        )
    }
    
    open func saveAuthToken(_ authToken: AuthToken) -> Void {
        
        // Need to delete the tokens from the keychain before saving. This is because overriding does not work with the keychain
        self.deleteTokenFromKeychain()
        
        
        if let accessToken = authToken.accessToken {
            self.keychain.set(value: accessToken, for: KeychainKey.accessToken.rawValue)
        }

        if let refreshToken = authToken.refreshToken {
            self.keychain.set(value: refreshToken, for: KeychainKey.refreshToken.rawValue)
        }
        
        if let expiry = authToken.expiry {
            self.keychain.set(value: expiry, for: KeychainKey.accessTokenExpiry.rawValue)
        }

        if let uniqueId = authToken.uniqueId {
            self.keychain.set(value: uniqueId, for: KeychainKey.uniqueId.rawValue)
        }
    }
    
    open func deleteTokenFromKeychain() {
        self.keychain.delete(by: KeychainKey.accessToken.rawValue)
        self.keychain.delete(by: KeychainKey.refreshToken.rawValue)
        self.keychain.delete(by: KeychainKey.accessTokenExpiry.rawValue)
        self.keychain.delete(by: KeychainKey.uniqueId.rawValue)
    }    
}
