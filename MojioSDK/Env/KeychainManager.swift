//
//  KeychainManager.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-03-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import KeychainSwift

public class AuthTokens : NSObject {
    public dynamic var authToken : String? = nil
    public dynamic var refreshToken : String? = nil
    public dynamic var expiryDate : String? = nil
    public dynamic var endpoint : String? = nil
}

public class KeychainKeys : NSObject {
    public static let AuthToken : String = "MojioAuthToken"
    public static let RefreshToken : String = "MojioAuthRefreshToken"
    public static let TokenExpiresIn : String = "MojioAuthTokenExpiresIn"
    public static let UrlEndpoint : String = "MojioEnvironmentEndpoint"
}

public class KeychainManager: NSObject {
    
    public func getAuthTokens () -> AuthTokens {
        let authTokens = AuthTokens.init()
        let keychain = KeychainSwift()

        authTokens.authToken = keychain.get(KeychainKeys.AuthToken)
        authTokens.refreshToken = keychain.get(KeychainKeys.RefreshToken)
        authTokens.expiryDate = keychain.get(KeychainKeys.TokenExpiresIn)
        authTokens.endpoint = keychain.get(KeychainKeys.UrlEndpoint)
        
        return authTokens
    }
    
    public func saveAuthenticationToken (token : String, refreshToken : String, expiresIn : Double, environmentEndpoint : String) -> Void {
        
        // Need to delete the tokens from the keychain before saving. This is because overriding does not work with the keychain
        self.deleteTokenFromKeychain()
        
        // Save the expiry date of the token in milliseconds since 1970 as it is timezone independent
        let currentTimeInMS : Double = NSDate().timeIntervalSince1970
        let expiryDateTimeInMS : Double = currentTimeInMS + (expiresIn * 1000)
        let expiryTime : NSString = String(format: "%f", expiryDateTimeInMS) as NSString
        
        let keychain = KeychainSwift()
        keychain.set(token, forKey: KeychainKeys.AuthToken)
        keychain.set(refreshToken, forKey : KeychainKeys.RefreshToken)
        keychain.set(expiryTime as String, forKey: KeychainKeys.TokenExpiresIn)
        keychain.set(environmentEndpoint, forKey: KeychainKeys.UrlEndpoint)
    }
    
    public func deleteTokenFromKeychain () {
        let keychain = KeychainSwift()
        keychain.delete(KeychainKeys.AuthToken)
        keychain.delete(KeychainKeys.RefreshToken)
        keychain.delete(KeychainKeys.TokenExpiresIn)
        keychain.delete(KeychainKeys.UrlEndpoint)
    }    
}
