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
import MojioCore

public enum GeofenceNotificationType: String, Codable {
    
    case onEnter = "OnEnter"
    case onExit = "OnExit"
    case always = "Always"
    case never = "Never"
    
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = GeofenceNotificationType(rawValue: label) ?? .unknown
    }
}

public protocol GeofenceModel: Codable, PrimaryKey {
    
    associatedtype G: GeofenceRegionModel
    
    var id: String { get }
    var ownerId: String? { get }
    var name: String? { get }
    var description: String? { get }
    var region: G? { get }
    var notificationSetting: GeofenceNotificationType? { get }
    var enabled: Bool { get }
    var vehicleIds: [String] { get }
    var tags: [String] { get }
    var deleted: Bool? { get }
    var createdOn: Date? { get }
    var lastModified: Date? { get }
}

public struct Geofence: GeofenceModel {
    
    public typealias G = GeofenceRegion
    
    public let id: String
    public let ownerId: String?
    public let name: String?
    public let description: String?
    public let region: G?
    public let notificationSetting: GeofenceNotificationType?
    public let enabled: Bool
    public let vehicleIds: [String]
    public let tags: [String]
    public let deleted: Bool?
    public let createdOn: Date?
    public let lastModified: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case ownerId = "OwnerId"
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notificationSetting = "NotificationSetting"
        case enabled = "Enabled"
        case vehicleIds = "VehicleIds"
        case tags = "Tags"
        case deleted = "Deleted"
        case createdOn = "CreatedOn"
        case lastModified = "LastModified"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? String.empty
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.region = try container.decodeIfPresent(G.self, forKey: .region)
            self.notificationSetting = try container.decodeIfPresent(GeofenceNotificationType.self, forKey: .notificationSetting)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
            self.vehicleIds = try container.decodeIfPresent([String].self, forKey: .vehicleIds) ?? []
            self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
