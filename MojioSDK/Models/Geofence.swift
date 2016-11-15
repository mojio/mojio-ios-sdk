//
//  Geofence.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 7/22/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class GeofenceRegionType : NSObject {
    open static let Circle = "Circle"
}

open class GeofenceRegion : Mappable {

    open dynamic var GeofenceType: String? = nil
    open dynamic var Lat: Double = 0
    open dynamic var Lng: Double = 0
    open var Radius: Distance? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let id = self.GeofenceType {
            dictionary["Type"] = id as AnyObject?
        }
        
        dictionary["Lat"] = self.Lat as AnyObject?
        dictionary["Lng"] = self.Lng as AnyObject?
        
        if let radius = self.Radius {
            dictionary["Radius"] = radius.jsonDict()
        }
        
        return dictionary as NSDictionary
    }
    
    open func mapping(map: Map) {
        GeofenceType <- map["Type"]
        Lat <- map["Lat"]
        Lng <- map["Lng"]
        Radius <- map["Radius"]
    }
}

open class Geofence: Mappable {
    
    open dynamic var Id : String? = nil
    open dynamic var Name: String? = nil
    open dynamic var Description: String? = nil
    open var Region: GeofenceRegion? = nil
    open var Tags : [String] = []
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func jsonDict() -> NSDictionary {
        var dictionary : [String:AnyObject] = [:]
        
        if let id = self.Id {
            dictionary["Id"] = id as AnyObject?
        }
        
        if let name = self.Name {
            dictionary["Name"] = name as AnyObject?
        }

        if let description = self.Description {
            dictionary["Description"] = description as AnyObject?
        }
        
        if let region = self.Region {
            dictionary["Region"] = region.jsonDict()
        }
        
        return dictionary as NSDictionary
    }
    
    open func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        Description <- map["Description"]
        Region <- map["Region"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Tags <- map["Tags"]
    }
}
