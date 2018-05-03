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
    case authToken = "MojioVehicleSDK.AuthToken"
}

private enum DeprecatedKeychainKey: String {
    case accessToken = "MojioSDKAccessToken"
    case refreshToken = "MojioSDKRefreshToken"
    case accessTokenExpiry = "MojioSDKAccessTokenExpiry"
    case uniqueId = "MojioSDKUniqueId"
}

protocol AuthTokenManager {
    var authToken: AuthToken? {get set}
    var authorizationKey: String? {get}
}

public final class KeychainManager: AuthTokenManager {
    
    public static var sharedInstance = KeychainManager()
    
    public init() {}
    
    public var authToken: AuthToken? {
        get {
            guard let authTokenData = KeychainSwift().getData(KeychainKey.authToken.rawValue) else {
                guard
                    let accessToken = KeychainSwift().get(by: DeprecatedKeychainKey.accessToken.rawValue),
                    let expiryTime = KeychainSwift().get(by: DeprecatedKeychainKey.accessTokenExpiry.rawValue),
                    let expiryInterval = Double(expiryTime),
                    let refreshToken = KeychainSwift().get(by: DeprecatedKeychainKey.refreshToken.rawValue),
                    let uniqueId = KeychainSwift().get(by: DeprecatedKeychainKey.uniqueId.rawValue) else {
                        return nil
                }

                let authToken = AuthToken(
                    accessToken: accessToken,
                    expiry: Date(timeIntervalSince1970: expiryInterval),
                    refreshToken: refreshToken,
                    uniqueId: uniqueId)

                self.authToken = authToken
                return authToken
            }
            
            do {
                return try PropertyListDecoder().decode(AuthToken.self, from: authTokenData)
            }
            catch let error {
                debugPrint(error)
            }
            
            return nil
        }
        set {
            // Need to delete the tokens from the keychain before saving (cannot overwrite)
            KeychainSwift().delete(KeychainKey.authToken.rawValue)
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            
            if let authToken = newValue {
                do {
                    KeychainSwift().set(try encoder.encode(authToken), forKey: KeychainKey.authToken.rawValue)
                }
                catch let error {
                    debugPrint(error)
                }
            }
        }
    }
    
    public var authorizationKey: String? {
        guard let accessToken = self.authToken?.accessToken else { return nil }
        return "Bearer \(accessToken)"
    }
    
    private func deleteTokenFromKeychain() {
        KeychainSwift().delete(by: DeprecatedKeychainKey.accessToken.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.refreshToken.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.accessTokenExpiry.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.uniqueId.rawValue)
    }
}
