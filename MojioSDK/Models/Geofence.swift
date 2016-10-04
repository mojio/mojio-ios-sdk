//
//  Geofence.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 7/22/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import Realm

public class GeofenceRegionType : NSObject {
    public static let Circle = "Circle"
}

public class GeofenceRegion : Object, Mappable {

    public dynamic var Type: String? = nil
    public dynamic var Lat: Double = 0
    public dynamic var Lng: Double = 0
    public dynamic var Radius: Distance? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
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

public class Geofence: Object, Mappable {
    
    public dynamic var Id : String? = nil
    public dynamic var Name: String? = nil
    public dynamic var Description: String? = nil
    public dynamic var Region: GeofenceRegion? = nil
    public var Tags = List<StringObject>()
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public override static func primaryKey() -> String? {
        return "Id"
    }
    
    public func TagsArray() -> NSArray {
        return self.Tags.toArray()
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
        
        return dictionary
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        Name <- map["Name"]
        Description <- map["Description"]
        Region <- map["Region"]
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }
    }
}
