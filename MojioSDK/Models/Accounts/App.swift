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
import MojioCore

public protocol AppModel: Codable, PrimaryKey {
    
    associatedtype I: ImageModel
    
    var id: String { get }
    var name: String? { get }
    var description: String? { get }
    var downloads: Int? { get }
    var redirectUris: [String] { get }
    var tags: [String] { get }
    var ownerId: String? { get }
    var deleted: Bool? { get }
    var image: I? { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
}

public struct App: AppModel {
    
    public typealias I = Image
    
    public let id: String
    public let name: String?
    public let description: String?
    public let downloads: Int?
    public let redirectUris: [String]
    public let tags: [String]
    public let ownerId: String?
    public let deleted: Bool?
    public let image: I?
    public let createdOn: Date?
    public let lastModified: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case description = "Description"
        case downloads = "Downloads"
        case redirectUris = "RedirectUris"
        case tags = "Tags"
        case ownerId = "OwnerId"
        case deleted = "Deleted"
        case image = "Image"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.downloads = try container.decodeIfPresent(Int.self, forKey: .downloads)
            self.redirectUris = try container.decodeIfPresent([String].self, forKey: .redirectUris) ?? []
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.image = try container.decodeIfPresent(Image.self, forKey: .image)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

//public func json () -> String? {
//    var map: [String: Any] = [:]
//
//    if let name = self.Name {
//        map["Name"] = name
//    }
//
//    if let desc = self.Description {
//        map["Description"] = desc
//    }
//
//    if self.RedirectUris.count > 0 {
//        map["RedirectUris"] = self.RedirectUris
//    }
//
//    if map.count == 0 {
//        return nil
//    }
//
//    let data = try! JSONSerialization.data(withJSONObject: map)
//    return String(data: data, encoding: String.Encoding.utf8)
//}
//
