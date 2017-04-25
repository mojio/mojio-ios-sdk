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

import Foundation
import ObjectMapper

public struct ActivityLocation: BaseActivityLocation {
    
    // BaseActivityLocation
    public var Id: String? = nil
    public var ActivityType: String? = nil
    public var Href: String? = nil
    public var Name: String? = nil
    public var NameMap: Dictionary<String, String>? = nil
    
    public var Latitude: Double = 0
    public var Longitude: Double = 0
    public var Altitude: Double = 0
    public var Radius: Double = 0
    
    public static var primaryKey: String {
        return "Id"
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func toLocation() -> Location {
        var location =  Location()
        location.Lat = self.Latitude
        location.Lng = self.Longitude
        location.Radius = self.Radius
        location.Altitude = self.Altitude
        
        if let name = self.Name {
            var address = Address()
            address.FormattedAddress = name
            location.LocationAddress = address
        }

        return location
    }
    
    public mutating func mapping(map: Map) {
        self.baseActivityLocationMapping(map: map)

        ActivityType <- map["Type"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        Altitude <- map["Altitude"]
        Radius <- map["Radius"]
    }
}
