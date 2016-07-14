//
//  ActivityLocation.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

public class ActivityLocation : BaseActivity {
    public dynamic var Latitude : Float = 0
    public dynamic var Longitude : Float = 0
    public dynamic var Altitude : Float = 0
    public dynamic var Radius : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func toLocation() -> Location {
        var location = Location()
        location.Lat = self.Latitude
        location.Lng = self.Longitude
        location.Altitude = self.Altitude
        if let name = super.Name {
            location.LocationAddress = Address()
            location.LocationAddress!.FormattedAddress = name
        }
        return location
    }
    
    public override func mapping(map: Map) {
        super.mapping(map)
        Type <- map["Type"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        Altitude <- map["Altitude"]
        Radius <- map["Radius"]
    }
    
}