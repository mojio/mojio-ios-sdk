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
import CoreLocation

public enum GeofenceRegionType: String, Codable {
    case circle = "Circle"
    case polygon = "Polygon"
}

public protocol GeofenceRegionModel: Codable {
    var latitude: Double? { get }
    var longitude: Double? { get }
    var radius: Double? { get }
    var polygon: String?  { get }
}

public struct GeofenceRegion: GeofenceRegionModel {
    
    public let latitude: Double?
    public let longitude: Double?
    public let radius: Double?
    public let polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
        case polygon = "Polygon"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
            self.polygon = try container.decodeIfPresent(String.self, forKey: .polygon)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public extension GeofenceRegion {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public struct GeofenceRegionUpdate: Codable {
    
    public var latitude: Double?
    public var longitude: Double?
    public var radius: Double?
    public var polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(
        latitude: Double? = nil,
        longitude: Double? = nil,
        radius: Double? = nil,
        polygon: String? = nil) {
        
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.polygon = polygon
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}

public protocol GeofenceNotificationModel: Codable {
    var onEnter: Bool { get }
    var onExit: Bool { get }
    var sound: String { get }
}

public struct GeofenceNotification: GeofenceNotificationModel {
    public let onEnter: Bool
    public let onExit: Bool
    public let sound: String
    
    public enum CodingKeys: String, CodingKey {
        case onEnter = "OnEnter"
        case onExit = "OnExit"
        case sound = "Sound"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.onEnter = (try container.decodeIfPresent(Bool.self, forKey: .onEnter)) ?? false
            self.onExit = (try container.decodeIfPresent(Bool.self, forKey: .onExit)) ?? false
            self.sound = (try container.decodeIfPresent(String.self, forKey: .sound)) ?? String.empty
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct GeofenceNotificationUpdate: Codable {
    public let onEnter: Bool
    public let onExit: Bool
    public let sound: String
    
    public init(
        onEnter: Bool,
        onExit: Bool,
        sound: String ) {
        
        self.onEnter = onEnter
        self.onExit = onExit
        self.sound = sound
    }
    
    public enum CodingKeys: String, CodingKey {
        case onEnter = "OnEnter"
        case onExit = "OnExit"
        case sound = "Sound"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.onEnter, forKey: .onEnter)
        try container.encodeIfPresent(self.onExit, forKey: .onExit)
        try container.encodeIfPresent(self.sound, forKey: .sound)
    }
}

public protocol GeofenceModel: Codable, PrimaryKey {
    
    associatedtype G: GeofenceRegionModel
    associatedtype N: GeofenceNotificationModel
    
    var id: String { get }
    var name: String? { get }
    var description: String? { get }
    var region: G? { get }
    var notification: N? { get }
    var assetIds: [String]? { get }
    var ownerId: String? { get }
    var deleted: Bool? { get }
    var lastModified: Date? { get }
    var createdOn: Date? { get }
}

public struct Geofence: GeofenceModel {
    
    public typealias G = GeofenceRegion
    public typealias N = GeofenceNotification
    
    public let id: String
    public let name: String?
    public let description: String?
    public let region: G?
    public let notification: N?
    public let assetIds: [String]?
    public let ownerId: String?
    public let deleted: Bool?
    public let lastModified: Date?
    public let createdOn: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notification = "Notification"
        case assetIds = "AssetIds"
        case ownerId = "OwnerId"
        case deleted = "Deleted"
        case lastModified = "LastModified"
        case createdOn = "CreatedOn"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            self.region = try container.decodeIfPresent(G.self, forKey: .region)
            self.notification = try container.decodeIfPresent(N.self, forKey: .notification)
            self.assetIds = try container.decodeIfPresent([String].self, forKey: .assetIds)
            self.ownerId = try container.decodeIfPresent(String.self, forKey: .ownerId)
            self.deleted = try container.decodeIfPresent(Bool.self, forKey: .deleted)
            self.lastModified = try container.decodeIfPresent(String.self, forKey: .lastModified).flatMap { $0.dateFromIso8601 }
            self.createdOn = try container.decodeIfPresent(String.self, forKey: .createdOn).flatMap { $0.dateFromIso8601 }
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public func ==(lhs: Geofence, rhs: Geofence) -> Bool {
    return lhs.id == rhs.id
}

public struct GeofenceUpdate: Codable {
    public var name: String? = nil
    public var description: String? = nil
    public var region: GeofenceRegionUpdate? = nil
    public var notification: GeofenceNotificationUpdate? = nil
    public var assetIds: [String]? = nil
    
    public init(
        name: String? = nil,
        description: String? = nil,
        region: GeofenceRegionUpdate? = nil,
        notification: GeofenceNotificationUpdate? = nil,
        assetIds: [String]? = nil) {
        
        self.name = name
        self.description = description
        self.region = region
        self.notification = notification
        self.assetIds = assetIds
    }
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case notification = "Notification"
        case assetIds = "AssetIds"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.notification, forKey: .notification)
        try container.encodeIfPresent(self.assetIds, forKey: .assetIds)
    }
}
