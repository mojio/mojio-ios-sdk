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

public protocol GeneralNotificationToken {
    var id: String { get }
    var platform: String? { get }
    var token: String? { get }
}

public struct NotificationToken: Codable, GeneralNotificationToken {
    public let id: String
    public let platform: String?
    public let token: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case platform = "Platform"
        case token = "Token"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.platform = try container.decodeIfPresent(String.self, forKey: .platform)
            self.token = try container.decodeIfPresent(String.self, forKey: .token)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
