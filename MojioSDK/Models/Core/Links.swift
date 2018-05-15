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

public protocol GeneralLinks {
    var linkSelf: URL? { get }
    var permission: URL? { get }
    var permissions: URL? { get }
    var first: URL? { get }
    var next: URL? { get }
}

public struct Links: Codable, GeneralLinks {
    public let linkSelf: URL?
    public let permission: URL?
    public let permissions: URL?
    public let first: URL?
    public let next: URL?
    
    public enum CodingKeys: String, CodingKey {
        case linkSelf = "Self"
        case permission = "Permission"
        case permissions = "Permissions"
        case first = "First"
        case next = "Next"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.linkSelf = try container.decodeIfPresent(URL.self, forKey: .linkSelf)
            self.permission = try container.decodeIfPresent(URL.self, forKey: .permission)
            self.permissions = try container.decodeIfPresent(URL.self, forKey: .permissions)
            self.first = try container.decodeIfPresent(URL.self, forKey: .first)
            self.next = try container.decodeIfPresent(URL.self, forKey: .next)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
