//
//  Geofence.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 7/22/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class GeofenceRegionType : NSObject {
    public static let Circle = "Circle"
}

public class GeofenceRegion : Mappable {

    public dynamic var Type: String? = nil
    public dynamic var Lat: Double = 0
    public dynamic var Lng: Double = 0
    public var Radius: Distance? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let id = self.Type {
            dictionary["Type"] = id
        }
        
        dictionary["Lat"] = self.Lat
        dictionary["Lng"] = self.Lng
        
        if let radius = self.Radius {
            dictionary["Radius"] = radius.jsonDict()
        }
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        Type <- map["Type"]
        Lat <- map["Lat"]
        Lng <- map["Lng"]
        Radius <- map["Radius"]
    }
}

public class Geofence: Mappable {
    
    public dynamic var Id : String? = nil
    public dynamic var Name: String? = nil
    public dynamic var Description: String? = nil
    public var Region: GeofenceRegion? = nil
    public dynamic var NotificationSetting: String? = nil
    public dynamic var Enabled: Bool = false
    public var VehicleIds: [String] = []
    public var Tags: [String] = []
    public dynamic var CreatedOn: String? = nil
    public dynamic var LastModified: String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let id = self.Id {
            dictionary["Id"] = id
        }
        
        if let name = self.Name {
            dictionary["Name"] = name
        }

        if let description = self.Description {
            dictionary["Description"] = description
        }
        
        if let region = self.Region {
            dictionary["Region"] = region.jsonDict()
        }
        
        if let notificationSetting = self.NotificationSetting {
            dictionary["NotificationSetting"] = notificationSetting
        }
        
        dictionary["Enabled"] = self.Enabled
        dictionary["VehicleIds"] = self.VehicleIds
        
        return dictionary
    }
    
    public func mapping(map: Map) {
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
    }
}
