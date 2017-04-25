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
import ObjectMapper

public enum GeofenceRegionType: String {
    case circle = "Circle"
}

public struct GeofenceRegion: Mappable {

    public var GeofenceType: String? = nil
    public var Lat: Double = 0
    public var Lng: Double = 0
    public var Radius: Distance? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonDict() -> [String: Any] {
        var map: [String:Any] = [:]
        
        if let id = self.GeofenceType {
            map["Type"] = id as AnyObject?
        }
        
        map["Lat"] = self.Lat as AnyObject?
        map["Lng"] = self.Lng as AnyObject?
        
        if let radius = self.Radius {
            map["Radius"] = radius.jsonDict()
        }
        
        return map
    }
    
    public mutating func mapping(map: Map) {
        GeofenceType <- map["Type"]
        Lat <- map["Lat"]
        Lng <- map["Lng"]
        Radius <- map["Radius"]
    }
}

public enum GeofenceNotificationType: String {
    case onEnter = "OnEnter"
    case onExit = "OnExit"
    case always = "Always"
    case never = "Never"
}

public struct Geofence: Mappable, PrimaryKey {
    
    public var Id: String? = nil
    public var Name: String? = nil
    public var Description: String? = nil
    public var Region: GeofenceRegion? = nil
    public var NotificationSetting: String? = nil
    public var Enabled: Bool = false
    public var VehicleIds: [String] = []
    public var Tags: [String] = []
    public var CreatedOn: String? = nil
    public var LastModified: String? = nil
    
    public var createdOn: Date? = nil
    public var lastModified: Date? = nil

    public static var primaryKey: String {
        return "Id"
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonDict() -> [String: Any] {
        var map: [String: Any] = [:]
        
        if let id = self.Id {
            map["Id"] = id as AnyObject?
        }
        
        if let name = self.Name {
            map["Name"] = name as AnyObject?
        }

        if let description = self.Description {
            map["Description"] = description as AnyObject?
        }
        
        if let region = self.Region {
            map["Region"] = region.jsonDict()
        }
        
        if let notificationSetting = self.NotificationSetting {
            map["NotificationSetting"] = notificationSetting as AnyObject?
        }
        
        map["Enabled"] = self.Enabled as AnyObject?
        map["VehicleIds"] = self.VehicleIds as AnyObject?
        
        return map
    }
    
    public mutating func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        Description <- map["Description"]
        Region <- map["Region"]
        NotificationSetting <- map["NotificationSetting"]
        Enabled <- map["Enabled"]
        VehicleIds <- map["VehicleIds"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Tags <- map["Tags"]
        
        createdOn = self.CreatedOn?.toDate
        lastModified = self.LastModified?.toDate
    }
}
