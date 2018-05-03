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
    public let Name: String?
    public let Description: String?
    public let Region: GeofenceRegion?
    public let NotificationSetting: GeofenceNotificationType?
    public let Enabled: Bool
    public let VehicleIds: [String]
    public let Tags: [String]
    public let CreatedOn: String?
    public let LastModified: String?
    public let OwnerId: String?
    public let Deleted: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name
        case Description
        case Region
        case NotificationSetting
        case Enabled
        case VehicleIds
        case Tags
        case CreatedOn
        case LastModified
        case OwnerId
        case Deleted
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
}
