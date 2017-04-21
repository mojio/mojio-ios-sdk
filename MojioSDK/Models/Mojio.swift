//
//  Mojio.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-10.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper


open class Mojio: Mappable {
    open dynamic var Id : String? = nil
    open dynamic var Name : String? = nil
    open dynamic var IMEI : String? = nil
    open dynamic var LastContactTime : String? = nil
    open dynamic var GatewayTime : String? = nil
    open dynamic var VehicleId : String? = nil
    open var MojioLocation : Location? = nil
    open var Tags : [String] = []
    open var Wifi : WifiRadio? = nil
    open var ConnectedState : BooleanState? = nil
    open dynamic var CreatedOn : String? = nil
    open dynamic var LastModified : String? = nil
    open dynamic var Deleted : Bool = false
    open dynamic var MSISDN: String? = nil
    open dynamic var ICCID: String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func json () -> String? {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if self.Name != nil {
            dictionary.setObject(self.Name!, forKey: "Name" as NSCopying)
        }
        if self.IMEI != nil {
            dictionary.setObject(self.IMEI!, forKey: "IMEI" as NSCopying)
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options:  JSONSerialization.WritingOptions.prettyPrinted)
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
    }
    
    open func mapping(map: Map) {
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
        MSISDN <- map["MSISDN"]
        ICCID <- map["ICCID"]
    }
}
