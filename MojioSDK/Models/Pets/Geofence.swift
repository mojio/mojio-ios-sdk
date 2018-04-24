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

enum GeofenceRegionType: String, Codable {
    case circle = "Circle"
}

struct GeofenceCircleRegion: Codable {
    let latitude: Double?
    let longitude: Double?
    let radius: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case radius = "Radius"
    }

    init(from decoder: Decoder) throws {
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

struct Geofence: Codable, Equatable {
    let id: String
    let name: String?
    let description: String?
    let region: GeofenceCircleRegion?
    let geofenceEnterNotification: Bool?
    let geofenceExitNotification: Bool?
    let assetIds: [String]?
    let ownerId: String?
    let deleted: Bool?
    let lastModified: Date?
    let createdOn: Date?
    
    enum CodingKeys: String, CodingKey {
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
    
    init(from decoder: Decoder) throws {
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

func ==(lhs: Geofence, rhs: Geofence) -> Bool {
    return lhs.id == rhs.id
}

struct GeofenceUpdate: Codable {
    var name: String? = nil
    var description: String? = nil
    var region: GeofenceCircleRegion? = nil
    var geofenceEnterNotification: Bool? = nil
    var geofenceExitNotification: Bool? = nil
    var assetIds: [String]? = nil
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
        case region = "Region"
        case geofenceEnterNotification = "GeofenceEnterNotification"
        case geofenceExitNotification = "GeofenceExitNotification"
        case assetIds = "AssetIds"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.region, forKey: .region)
        try container.encodeIfPresent(self.geofenceEnterNotification, forKey: .geofenceEnterNotification)
        try container.encodeIfPresent(self.geofenceExitNotification, forKey: .geofenceExitNotification)
        try container.encodeIfPresent(self.assetIds, forKey: .assetIds)
    }
}
