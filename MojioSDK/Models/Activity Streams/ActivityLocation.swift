//
//  ActivityLocation.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

open class ActivityLocation : BaseActivity {
    open dynamic var Latitude : Float = 0
    open dynamic var Longitude : Float = 0
    open dynamic var Altitude : Float = 0
    open dynamic var Radius : Float = 0
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    open func toLocation() -> Location {
        let location = Location()
        location.Lat = self.Latitude
        location.Lng = self.Longitude
        location.Radius = self.Radius
        location.Altitude = self.Altitude
        if let name = super.Name {
            location.LocationAddress = Address()
            location.LocationAddress!.FormattedAddress = name
        }
        return location
    }
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        ActivityType <- map["Type"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        Altitude <- map["Altitude"]
        Radius <- map["Radius"]
    }
    
}
