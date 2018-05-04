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

public enum GeofenceRegionType: String, Codable {
    
    case circle = "Circle"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = GeofenceRegionType(rawValue: label) ?? .unknown
    }
}

public struct GeofenceRegion: Codable {

    public var type: GeofenceRegionType? = nil
    public var lat: Double? = 0
    public var lng: Double? = 0
    public var radius: Distance? = nil
        
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.type = try container.decodeIfPresent(GeofenceRegionType.self, forKey: .type)
            self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
            self.lng = try container.decodeIfPresent(Double.self, forKey: .lng)
            self.radius = try container.decodeIfPresent(Distance.self, forKey: .radius)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

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

public struct Geofence: Codable, PrimaryKey {
    
    public let id: String
    public let ownerId: String?
    public let name: String?
    public let description: String?
    public let region: GeofenceRegion?
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
            self.region = try container.decodeIfPresent(GeofenceRegion.self, forKey: .region)
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
