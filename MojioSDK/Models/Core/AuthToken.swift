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

import Foundation

public protocol AuthTokenModel: Codable {
    var accessToken: String { get }
    var expiry: Date { get }
    var refreshToken: String? { get }
    var uniqueId: String? { get }
}

public struct AuthToken: AuthTokenModel {
    public var accessToken: String = String.empty
    public var expiry: Date = Date()
    public var refreshToken: String? = nil
    public var uniqueId: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiry = "expires_in"
        case refreshToken = "refresh_token"
        case uniqueId = "uniqueId"
    }
    
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.accessToken = try container.decode(String.self, forKey: .accessToken)
            self.expiry = try container.decode(Date.self, forKey: .expiry)
            self.refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
            self.uniqueId = try container.decodeIfPresent(String.self, forKey: .uniqueId)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }

    public init(accessToken: String, expiry: Date, refreshToken: String?, uniqueId: String) {
        self.accessToken = accessToken
        self.expiry = expiry
        self.refreshToken = refreshToken
        self.uniqueId = uniqueId
    }
    
    public var expiryTimestamp: Double {
        return self.expiry.timeIntervalSince1970
    }
    
    public var isValid: Bool {
        guard let _ = self.uniqueId else {
            return false
        }
        
        let currentTime: Double = Date().timeIntervalSince1970
        
        // Check for expiry
        if currentTime > self.expiryTimestamp {
            return false
        }
        
        return true
    }
}
