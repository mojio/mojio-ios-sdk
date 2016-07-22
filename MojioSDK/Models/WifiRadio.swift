//
//  WifiRadio.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-27.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class TransactionState: NSObject {
    public static let Pending = "Pending"
    public static let Success = "Success"
    public static let Failure = "Failure"
}

public class WifiRadioStatus: NSObject {
    public static let Connected = "Connected"
    public static let Roaming = "Roaming"
    public static let Disconnected = "Disconnected"
}

public class WifiRadio: Object, Mappable  {
    
    public dynamic var TimeStamp : String? = nil
    public dynamic var SSID : String? = nil
    public dynamic var Password : String? = nil
    public dynamic var AllowRoaming : String? = nil
    public dynamic var Status : String? = nil
    public dynamic var Strength : String? = nil

    public required convenience init?(_ map: Map) {
        self.init()
    }
   
    // Time to live in seconds for the update request 
    public func jsonDict(timeToLive: Int? = nil) -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        if let ssid = self.SSID {
            dictionary.setObject(ssid, forKey: "SSID")
        }

        if let password = self.Password {
            dictionary.setObject(password, forKey: "Password")
        }
        
        if let status = self.Status {
            dictionary.setObject(status, forKey: "Status")
        }
        
        if let timeToLive: Int = timeToLive where timeToLive > 0 {
            dictionary.setObject(NSNumber(long: timeToLive).stringValue, forKey: "TimeToLive")
        }
        
        return dictionary
    }

    public func mapping (map : Map) {
        TimeStamp <- map["TimeStamp"]
        SSID <- map["SSID"]
        Password <- map["Password"]
        AllowRoaming <- map["AllowRoaming"]
        Status <- map["Status"]
        Strength <- map["Strength"]
    }

}
