/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit
import ObjectMapper

public enum TransactionState: String {
    case pending = "Pending"
    case success = "Success"
    case failure = "Failure"
}

public enum WifiRadioStatus: String {
    case connected = "Connected"
    case roaming = "Roaming"
    case disconnected = "Disconnected"
}

public struct WifiRadio: Mappable  {
    
    public var TimeStamp: String? = nil
    public var SSID: String? = nil
    public var Password: String? = nil
    public var AllowRoaming: String? = nil
    public var Status: String? = nil
    public var Strength: String? = nil

    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    // Time to live in seconds for the update request
    public func jsonDict(_ timeToLive: Int? = nil, fields: [String]? = nil) -> [String: Any] {
        var map: [String: Any] = [:]
        
        // Default to use all fields
        var updateFields: Set<String> = ["SSID", "Password", "Status"]
        if let fields = fields {
            updateFields = Set<String>(fields)
        }

        if let ssid = self.SSID , updateFields.contains("SSID") {
            map["SSID"] = ssid
        }

        if let password = self.Password , updateFields.contains("Password") {
            map["Password"] = password
        }

        if let status = self.Status, updateFields.contains("Status") {
            map["Status"] = status
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
                map["TimeToLive"] = timespan
            }
        }
        
        return map
    }

    public mutating func mapping(map: Map) {
        TimeStamp <- map["TimeStamp"]
        SSID <- map["SSID"]
        Password <- map["Password"]
        AllowRoaming <- map["AllowRoaming"]
        Status <- map["Status"]
        Strength <- map["Strength"]
    }

}
