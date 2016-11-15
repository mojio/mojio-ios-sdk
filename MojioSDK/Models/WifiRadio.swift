//
//  WifiRadio.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-06-27.
//
//

import UIKit
import ObjectMapper

open class TransactionState: NSObject {
    open static let Pending = "Pending"
    open static let Success = "Success"
    open static let Failure = "Failure"
}

open class WifiRadioStatus: NSObject {
    open static let Connected = "Connected"
    open static let Roaming = "Roaming"
    open static let Disconnected = "Disconnected"
}

open class WifiRadio: Mappable  {
    
    open dynamic var TimeStamp : String? = nil
    open dynamic var SSID : String? = nil
    open dynamic var Password : String? = nil
    open dynamic var AllowRoaming : String? = nil
    open dynamic var Status : String? = nil
    open dynamic var Strength : String? = nil

    public required convenience init?(map: Map) {
        self.init()
    }
   
    public required init() {
        
    }

    // Time to live in seconds for the update request
    open func jsonDict(_ timeToLive: Int? = nil, fields: [String]? = nil) -> NSDictionary {
        let dictionary : NSMutableDictionary = NSMutableDictionary()
        
        // Default to use all fields
        var updateFields: Set<String> = ["SSID", "Password", "Status"]
        if let fields = fields {
            updateFields = Set<String>(fields)
        }

        if let ssid = self.SSID , updateFields.contains("SSID") {
            dictionary.setObject(ssid, forKey: "SSID" as NSCopying)
        }

        if let password = self.Password , updateFields.contains("Password") {
            dictionary.setObject(password, forKey: "Password" as NSCopying)
        }

        if let status = self.Status , updateFields.contains("Status") {
            dictionary.setObject(status, forKey: "Status" as NSCopying)
        }

        if let timeToLive: Int = timeToLive , timeToLive > 0 {
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 2
            formatter.maximumIntegerDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            
            var timespan = ""

            let seconds = formatter.string(from: NSNumber(value: timeToLive % 60 as Int)) ?? ""
            if timeToLive < 60 {
                // Less than 60 seconds
                timespan = String(format:"00:00:%@", seconds)
            }
            else {
                let minutes = formatter.string(from: NSNumber(value: (timeToLive % 3600) / 60 as Int)) ?? ""
                if timeToLive < 3600 {
                    // Less than 1 hour
                    timespan = String(
                        format:"00:%@:%@",
                        minutes,
                        seconds)
                }
                else {
                    let hours = formatter.string(from: NSNumber(value: timeToLive / 3600 as Int)) ?? ""
                    timespan = String(format:"%@:%@:%@", hours, minutes, seconds)
                }
            }
            
            if timespan.characters.count > 0 {
                dictionary.setObject(timespan, forKey: "TimeToLive" as NSCopying)
            }
        }
        
        return dictionary
    }

    open func mapping(map : Map) {
        TimeStamp <- map["TimeStamp"]
        SSID <- map["SSID"]
        Password <- map["Password"]
        AllowRoaming <- map["AllowRoaming"]
        Status <- map["Status"]
        Strength <- map["Strength"]
    }

}
