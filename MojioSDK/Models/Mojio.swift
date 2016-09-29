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

public class Mojio: Mappable {
    public dynamic var Id : String? = nil
    public dynamic var Name : String? = nil
    public dynamic var IMEI : String? = nil
    public dynamic var LastContactTime : String? = nil
    public dynamic var GatewayTime : String? = nil
    public dynamic var VehicleId : String? = nil
    public var MojioLocation : Location? = nil
    public var Tags : [String] = []
    public var Wifi : WifiRadio? = nil
    public var ConnectedState : BooleanState? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    public dynamic var Deleted : Bool = false

    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "Id"
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
        Id <- map["Id"]
        Name <- map["Name"]
        IMEI <- map["IMEI"]
        LastContactTime <- map["LastContactTime"]
        Wifi <- map["WifiRadio"]
        GatewayTime <- map["GatewayTime"]
        VehicleId <- map["VehicleId"]
        MojioLocation <- map["Location"]
        ConnectedState <- map["ConnectedState"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Tags <- map["Tags"]
        Deleted <- map["Deleted"]
    }
}
