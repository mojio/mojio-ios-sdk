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

public struct GeofenceRegion: Codable {

    public var type: GeofenceRegionType? = nil
    public var lat: Double? = 0
    public var lng: Double? = 0
    public var radius: Distance? = nil
    
//    public func jsonDict() -> [String: Any] {
//        var map: [String:Any] = [:]
//
//        if let id = self.GeofenceType {
//            map["Type"] = id as AnyObject?
//        }
//
//        map["Lat"] = self.Lat as AnyObject?
//        map["Lng"] = self.Lng as AnyObject?
//
//        if let radius = self.Radius {
//            map["Radius"] = radius.jsonDict()
//        }
//
//        return map
//    }
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
    }
}

public enum GeofenceNotificationType: String, Codable {
    case onEnter = "OnEnter"
    case onExit = "OnExit"
    case always = "Always"
    case never = "Never"
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
}

//    public func jsonDict() -> [String: Any] {
//        var map: [String: Any] = [:]
//
//        if let id = self.Id {
//            map["Id"] = id as AnyObject?
//        }
//
//        if let name = self.Name {
//            map["Name"] = name as AnyObject?
//        }
//
//        if let description = self.Description {
//            map["Description"] = description as AnyObject?
//        }
//
//        if let region = self.Region {
//            map["Region"] = region.jsonDict()
//        }
//
//        if let notificationSetting = self.NotificationSetting {
//            map["NotificationSetting"] = notificationSetting as AnyObject?
//        }
//
//        map["Enabled"] = self.Enabled as AnyObject?
//        map["VehicleIds"] = self.VehicleIds as AnyObject?
//
//        return map
//    }
