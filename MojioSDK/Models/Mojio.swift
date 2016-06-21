//
//  Mojio.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Mojio: Object, Mappable, Entity {
    public dynamic var Id : String? = nil
    public dynamic var Name : String? = nil
    public dynamic var IMEI : String? = nil
    public dynamic var LastContactTime : String? = nil
    public dynamic var GatewayTime : String? = nil
    public dynamic var VehicleId : String? = nil
    public dynamic var MojioLocation : Location? = nil
    public var Tags = List<StringObject>()
    public dynamic var ConnectedState : Bool = false
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
    
    public func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.IMEI != nil {
            dictionary.setObject(self.IMEI!, forKey: "IMEI")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
        
    }

    
    public func mapping(map: Map) {
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        Id <- map["Id"];
        Name <- map["Name"];
        IMEI <- map["IMEI"];
        LastContactTime <- map["LastContactTime"];
        GatewayTime <- map["GatewayTime"];
        VehicleId <- map["VehicleId"];
        MojioLocation <- map["Location"];
        ConnectedState <- map["ConnectedState"]
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }
}
