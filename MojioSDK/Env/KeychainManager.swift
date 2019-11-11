/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2018 Copyright Moj.io Inc.
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
    
    private init() {
        self.encoder.outputFormat = .binary
        
        if let authToken = self.deprecatedAuthToken {
            self.authToken = authToken
            self.deleteDeprecatedTokenFromKeychain()
        }
    }
    
    private let keychainSwift = KeychainSwift()
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    private let lock = NSLock()
    private var authTokenCache: AuthToken? // Cache for the tocken's value to reduce reading operations
    
    public var authToken: AuthToken? {
        get {
            self.lock.lock()
            defer { self.lock.unlock() }
            
            if self.authTokenCache == nil {
                self.authTokenCache = self.readToken()
            }
            return self.authTokenCache
        }
        set {
            self.lock.lock()
            defer { self.lock.unlock() }
            
            self.saveToken(newValue)
            self.authTokenCache = newValue
        }
    }
    
    public var authorizationKey: String? {
        return self.authToken.map{ "Bearer \($0.accessToken)" }
    }
    
    // save/read token
    private func readToken() -> AuthToken? {
        guard let authTokenData = self.keychainSwift.getData(KeychainKey.authToken.rawValue) else { return nil }
        do {
            return try PropertyListDecoder().decode(AuthToken.self, from: authTokenData)
        }
        catch let error {
            debugPrint(error)
            return nil
        }
    }
    
    private func saveToken(_ authToken: AuthToken?) {
        // Need to delete the tokens from the keychain before saving (cannot overwrite)
        self.keychainSwift.delete(KeychainKey.authToken.rawValue)
        
        guard let authToken = authToken else { return }
        do {
            self.keychainSwift.set(try self.encoder.encode(authToken), forKey: KeychainKey.authToken.rawValue, withAccess: .accessibleAfterFirstUnlockThisDeviceOnly)
        }
        catch let error {
            debugPrint(error)
        }
    }
    
    // Supporting deprecated keys
    var deprecatedAuthToken: AuthToken? {
        if
            let accessToken = KeychainSwift().get(by: DeprecatedKeychainKey.accessToken.rawValue),
            let expiryTime = KeychainSwift().get(by: DeprecatedKeychainKey.accessTokenExpiry.rawValue),
            let expiryInterval = Double(expiryTime),
            let refreshToken = KeychainSwift().get(by: DeprecatedKeychainKey.refreshToken.rawValue),
            let uniqueId = KeychainSwift().get(by: DeprecatedKeychainKey.uniqueId.rawValue) {
            
            return AuthToken(
                accessToken: accessToken,
                expiry: Date(timeIntervalSince1970: expiryInterval),
                refreshToken: refreshToken,
                // PHIOS-1188: Unique name changed for production
                uniqueId: uniqueId.count == 0 ? MojioRegion.RegionType.production.rawValue : uniqueId)
        }
        return nil
    }
    
    private func deleteDeprecatedTokenFromKeychain() {
        KeychainSwift().delete(by: DeprecatedKeychainKey.accessToken.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.refreshToken.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.accessTokenExpiry.rawValue)
        KeychainSwift().delete(by: DeprecatedKeychainKey.uniqueId.rawValue)
    }
}
