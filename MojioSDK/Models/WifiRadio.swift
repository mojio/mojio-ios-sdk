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
    public func jsonDict(timeToLive: Int? = nil, fields: [String]? = nil) -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        // Default to use all fields
        var updateFields: Set<String> = ["SSID", "Password", "Status"]
        if let fields = fields {
            updateFields = Set<String>(fields)
        }

        if let ssid = self.SSID where updateFields.contains("SSID") {
            dictionary.setObject(ssid, forKey: "SSID")
        }

        if let password = self.Password where updateFields.contains("Password") {
            dictionary.setObject(password, forKey: "Password")
        }

        if let status = self.Status where updateFields.contains("Status") {
            dictionary.setObject(status, forKey: "Status")
        }

        if let timeToLive: Int = timeToLive where timeToLive > 0 {
            let formatter = NSNumberFormatter()
            formatter.minimumIntegerDigits = 2
            formatter.maximumIntegerDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            
            var timespan = ""

            let seconds = formatter.stringFromNumber(NSNumber(long: timeToLive % 60)) ?? ""
            if timeToLive < 60 {
                // Less than 60 seconds
                timespan = String(format:"00:00:%@", seconds)
            }
            else {
                let minutes = formatter.stringFromNumber(NSNumber(long: (timeToLive % 3600) / 60)) ?? ""
                if timeToLive < 3600 {
                    // Less than 1 hour
                    timespan = String(
                        format:"00:%@:%@",
                        minutes,
                        seconds)
                }
                else {
                    let hours = formatter.stringFromNumber(NSNumber(long: timeToLive / 3600)) ?? ""
                    timespan = String(format:"%@:%@:%@", hours, minutes, seconds)
                }
            }
            
            if timespan.characters.count > 0 {
                dictionary.setObject(timespan, forKey: "TimeToLive")
            }
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
