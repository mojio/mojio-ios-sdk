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
import MojioCore

public protocol GeneralGroup {
    
    associatedtype U: GeneralUser
    
    var id: String { get }
    var name: String? { get }
    var description: String? { get }
    var users: [U] { get }
    var tags: [String] { get }
    var ownerId: String? { get }
    var deleted: Bool? { get }
    var createdOn: String? { get }
    var lastModified: String? { get }
}

public struct Group: Codable, PrimaryKey, GeneralGroup {
    
    public typealias U = User
    
    public let id: String
    public let name: String?
    public let description: String?
    public let users: [U]
    public let tags: [String]
    public let ownerId: String?
    public let deleted: Bool?
    public let createdOn: String?
    public let lastModified: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case description = "Description"
        case users = "Users"
        case tags = "Tags"
        case ownerId = "OwnerId"
        case deleted = "Deleted"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    /* public func json () -> String? {
        var map: [String: Any] = [:]
        
        if let name = self.Name {
            map["Name"] = name
        }

        if let desc = self.Description {
            map["Description"] = desc
        }

        if self.Users.count > 0 {
            map["Users"] = self.Users
        }
        
        let data = try! JSONSerialization.data(withJSONObject: map)
        return String(data: data, encoding: String.Encoding.utf8)
    } */
}
