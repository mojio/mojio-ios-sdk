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
            
            self.id = try container.decodeIfPresentIgnoringCase(String.self, forKey: .id) ?? String.empty
            self.ownerId = try container.decodeIfPresentIgnoringCase(String.self, forKey: .ownerId)
            self.name = try container.decodeIfPresentIgnoringCase(String.self, forKey: .name)
            self.description = try container.decodeIfPresentIgnoringCase(String.self, forKey: .description)
            self.region = try container.decodeIfPresentIgnoringCase(G.self, forKey: .region)
            self.notificationSetting = try container.decodeIfPresentIgnoringCase(GeofenceNotificationType.self, forKey: .notificationSetting)
            self.enabled = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: .enabled) ?? false
            self.vehicleIds = try container.decodeIfPresentIgnoringCase([String].self, forKey: .vehicleIds) ?? []
            self.tags = try container.decodeIfPresentIgnoringCase([String].self, forKey: .tags) ?? []
            self.deleted = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: .deleted)
            self.createdOn = try container.decodeIfPresentIgnoringCase(String.self, forKey: .createdOn).flatMap { $0.dateFromISO }
            self.lastModified = try container.decodeIfPresentIgnoringCase(String.self, forKey: .lastModified).flatMap { $0.dateFromISO }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.ownerId, forKey: .ownerId)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.notificationSetting, forKey: .notificationSetting)
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.vehicleIds, forKey: .vehicleIds)
        try container.encodeIfPresent(self.tags, forKey: .tags)
        try container.encodeIfPresent(self.deleted, forKey: .deleted)
        try container.encodeIfPresent(self.createdOn, forKey: .createdOn)
        try container.encodeIfPresent(self.lastModified, forKey: .lastModified)
    }
}

public func ==(lhs: Geofence, rhs: Geofence) -> Bool {
    return lhs.id == rhs.id
}

public struct GeofenceUpdate: Codable {
    public var name: String? = nil
    public var description: String? = nil
    public var region: GeofenceRegionUpdate? = nil
    public var notificationSetting: GeofenceNotificationType? = nil
    public var vehicleIds: [String] = []
    
    public init(
        name: String? = nil,
        description: String? = nil,
        region: GeofenceRegionUpdate? = nil,
        notificationSetting: GeofenceNotificationType? = nil,
        vehicleIds: [String] = []) {
        
        self.name = name
        self.description = description
        self.region = region
        self.notificationSetting = notificationSetting
        self.vehicleIds = vehicleIds
    }
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notificationSetting = "NotificationSetting"
        case vehicleIds = "VehicleIds"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.notificationSetting, forKey: .notificationSetting)
        try container.encodeIfPresent(self.vehicleIds, forKey: .vehicleIds)
    }
}
