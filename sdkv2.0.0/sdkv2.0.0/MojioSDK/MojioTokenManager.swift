//
//  MojioTokenManager.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-03-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import KeychainSwift

class MojioTokenManager: NSObject {
    
    private let MOJIO_AUTH_TOKEN_STRING = "MojioAuthToken"
    private let MOJIO_REFRESH_TOKEN_STRING = "MojioAuthRefreshToken"
    private let MOJIO_TOKEN_EXPIRES_STRING = "MojioAuthTokenExpiresIn"
    
    func getAuthToken () -> (String?, String?, NSString?) {
        let keychain = KeychainSwift()
        let authToken : String? = keychain.get(self.MOJIO_AUTH_TOKEN_STRING)
        let refreshToken : String? = keychain.get(self.MOJIO_REFRESH_TOKEN_STRING)
        let expiryDate : NSString? = keychain.get(self.MOJIO_TOKEN_EXPIRES_STRING)
        
        return (authToken, refreshToken, expiryDate)
    }
    
    func saveAuthenticationToken (token : String, refreshToken : String, expiresIn : Double) -> Void {
        
        // Need to delete the tokens from the keychain before saving. This is because overriding does not work with the keychain
        self.deleteTokenFromKeychain()
        
        // Save the expiry date of the token in milliseconds since 1970 as it is timezone independent
        let currentTimeInMS : Double = NSDate().timeIntervalSince1970
        let expiryDateTimeInMS : Double = currentTimeInMS + (expiresIn * 1000)
        let expiryTime : NSString = String(format: "%f", expiryDateTimeInMS) as NSString
        
        let keychain = KeychainSwift()
        keychain.set(token, forKey: self.MOJIO_AUTH_TOKEN_STRING)
        keychain.set(refreshToken, forKey : self.MOJIO_REFRESH_TOKEN_STRING)
        keychain.set(expiryTime as String, forKey: self.MOJIO_TOKEN_EXPIRES_STRING)
    }
    
    func deleteTokenFromKeychain () {
        let keychain = KeychainSwift()
        keychain.delete(self.MOJIO_AUTH_TOKEN_STRING)
        keychain.delete(self.MOJIO_REFRESH_TOKEN_STRING)
        keychain.delete(self.MOJIO_TOKEN_EXPIRES_STRING)
    }


}
