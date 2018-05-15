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
}

public protocol GeneralGeofenceCircleRegion {
    var latitude: Double? { get }
    var longitude: Double? { get }
    var radius: Double? { get }
}

public struct GeofenceCircleRegion: Codable, GeneralGeofenceCircleRegion {
    
    public let latitude: Double?
    public let longitude: Double?
    public let radius: Double?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public protocol GeneralGeofence {
    
    associatedtype G: GeneralGeofenceCircleRegion
    
    var id: String { get }
    var name: String? { get }
    var description: String? { get }
    var region: G? { get }
    var geofenceEnterNotification: Bool? { get }
    var geofenceExitNotification: Bool? { get }
    var assetIds: [String]? { get }
    var ownerId: String? { get }
    var deleted: Bool? { get }
    var lastModified: Date? { get }
    var createdOn: Date? { get }
}

public struct Geofence: Codable, PrimaryKey, GeneralGeofence {
    
    public typealias G = GeofenceCircleRegion
    
    public let id: String
    public let name: String?
    public let description: String?
    public let region: G?
    public let geofenceEnterNotification: Bool?
    public let geofenceExitNotification: Bool?
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
        case geofenceEnterNotification = "GeofenceEnterNotification"
        case geofenceExitNotification = "GeofenceExitNotification"
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
            self.region = try container.decodeIfPresent(GeofenceCircleRegion.self, forKey: .region)
            self.geofenceEnterNotification = try container.decodeIfPresent(Bool.self, forKey: .geofenceEnterNotification)
            self.geofenceExitNotification = try container.decodeIfPresent(Bool.self, forKey: .geofenceExitNotification)
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
    public var region: GeofenceCircleRegion? = nil
    public var geofenceEnterNotification: Bool? = nil
    public var geofenceExitNotification: Bool? = nil
    public var assetIds: [String]? = nil
    
    public enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case geofenceEnterNotification = "GeofenceEnterNotification"
        case geofenceExitNotification = "GeofenceExitNotification"
        case assetIds = "AssetIds"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.geofenceEnterNotification, forKey: .geofenceEnterNotification)
        try container.encodeIfPresent(self.geofenceExitNotification, forKey: .geofenceExitNotification)
        try container.encodeIfPresent(self.assetIds, forKey: .assetIds)
    }
}
