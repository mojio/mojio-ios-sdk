//
//  Mojio.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Mojio: Object, Mappable {
    dynamic var Name : String? = nil
    dynamic var IMEI : String? = nil
    dynamic var LastContactTime : String? = nil
    dynamic var GatewayTime : String? = nil
    dynamic var VehicleId : String? = nil
    var Tags = List<StringObject>()
    dynamic var Id : String? = nil
    dynamic var CreatedOn : String? = nil
    dynamic var LastModified : String? = nil

    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func json () -> NSString? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name")
        }
        if self.IMEI != nil {
            dictionary.setObject(self.IMEI!, forKey: "IMEI")
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options:  NSJSONWritingOptions.PrettyPrinted)
        let string : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        return string
        
    }

    
    func mapping(map: Map) {
        
        var tags = Array<String>()
        tags <- map["Tags"]
        
        for tag in tags {
            let string = StringObject()
            string.value = tag
            
            self.Tags.append(string)
        }

        Name <- map["Name"];
        IMEI <- map["IMEI"];
        LastContactTime <- map["LastContactTime"];
        GatewayTime <- map["GatewayTime"];
        VehicleId <- map["VehicleId"];
//        Tags <- map["Tags"];
        Id <- map["Id"];
        CreatedOn <- map["CreatedOn"];
        LastModified <- map["LastModified"];
    }
}
