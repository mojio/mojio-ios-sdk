/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

public protocol LinksModel: Codable {
    var linkSelf: String? { get }
    var permission: String? { get }
    var permissions: String? { get }
    var first: String? { get }
    var next: String? { get }
}

public struct Links: LinksModel {
    public let linkSelf: String?
    public let permission: String?
    public let permissions: String?
    public let first: String?
    public let next: String?
    
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
            self.linkSelf = try container.decodeIfPresent(String.self, forKey: .linkSelf)
            self.permission = try container.decodeIfPresent(String.self, forKey: .permission)
            self.permissions = try container.decodeIfPresent(String.self, forKey: .permissions)
            self.first = try container.decodeIfPresent(String.self, forKey: .first)
            self.next = try container.decodeIfPresent(String.self, forKey: .next)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
