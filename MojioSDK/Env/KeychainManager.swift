//
//  KeychainManager.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import KeychainSwift

open class KeychainKeys : NSObject {
    open static let AccessToken: String = "MojioSDKAccessToken"
    open static let RefreshToken: String = "MojioSDKRefreshToken"
    open static let AccessTokenExpiry: String = "MojioSDKAccessTokenExpiry"
    open static let UniqueId: String = "MojioSDKUniqueId"
}

open class KeychainManager: NSObject {
    
    open func getAuthToken() -> AuthToken {
        let authToken = AuthToken.init()
        let keychain = KeychainSwift()

        authToken.accessToken = keychain.get(KeychainKeys.AccessToken)
        authToken.refreshToken = keychain.get(KeychainKeys.RefreshToken)
        authToken.expiry = keychain.get(KeychainKeys.AccessTokenExpiry)
        authToken.uniqueId = keychain.get(KeychainKeys.UniqueId)
        
        return authToken
    }
    
    open func saveAuthToken(_ authToken: AuthToken) -> Void {
        
        // Need to delete the tokens from the keychain before saving. This is because overriding does not work with the keychain
        self.deleteTokenFromKeychain()
        
        let keychain = KeychainSwift()
        
        if let accessToken: String = authToken.accessToken {
            keychain.set(accessToken, forKey: KeychainKeys.AccessToken)
        }

        if let refreshToken: String = authToken.refreshToken {
            keychain.set(refreshToken, forKey : KeychainKeys.RefreshToken)
        }
        
        if let expiry: String = authToken.expiry {
            keychain.set(expiry as String, forKey: KeychainKeys.AccessTokenExpiry)
        }

        if let uniqueId: String = authToken.uniqueId {
            keychain.set(uniqueId, forKey: KeychainKeys.UniqueId)
        }
    }
    
    open func deleteTokenFromKeychain() {
        let keychain = KeychainSwift()
        keychain.delete(KeychainKeys.AccessToken)
        keychain.delete(KeychainKeys.RefreshToken)
        keychain.delete(KeychainKeys.AccessTokenExpiry)
        keychain.delete(KeychainKeys.UniqueId)
    }    
}
