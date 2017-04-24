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
    
    open func getAuthToken() -> AuthToken {
        var authToken = AuthToken.init()
        let keychain = KeychainSwift()

        authToken.accessToken = keychain.get(KeychainKey.accessToken.rawValue)
        authToken.refreshToken = keychain.get(KeychainKey.refreshToken.rawValue)
        authToken.expiry = keychain.get(KeychainKey.accessTokenExpiry.rawValue)
        authToken.uniqueId = keychain.get(KeychainKey.uniqueId.rawValue)
        
        return authToken
    }
    
    open func saveAuthToken(_ authToken: AuthToken) -> Void {
        
        // Need to delete the tokens from the keychain before saving. This is because overriding does not work with the keychain
        self.deleteTokenFromKeychain()
        
        let keychain = KeychainSwift()
        
        if let accessToken: String = authToken.accessToken {
            keychain.set(accessToken, forKey: KeychainKey.accessToken.rawValue)
        }

        if let refreshToken: String = authToken.refreshToken {
            keychain.set(refreshToken, forKey: KeychainKey.refreshToken.rawValue)
        }
        
        if let expiry: String = authToken.expiry {
            keychain.set(expiry as String, forKey: KeychainKey.accessTokenExpiry.rawValue)
        }

        if let uniqueId: String = authToken.uniqueId {
            keychain.set(uniqueId, forKey: KeychainKey.uniqueId.rawValue)
        }
    }
    
    open func deleteTokenFromKeychain() {
        let keychain = KeychainSwift()
        keychain.delete(KeychainKey.accessToken.rawValue)
        keychain.delete(KeychainKey.refreshToken.rawValue)
        keychain.delete(KeychainKey.accessTokenExpiry.rawValue)
        keychain.delete(KeychainKey.uniqueId.rawValue)
    }    
}
