//
//  ActivityLocation.swift
//  MojioSDK
//
//  Created by Narayan Sainaney on 2016-06-27.
//  Copyright © 2016 Mojio. All rights reserved.
//

import Foundation
import ObjectMapper

@objc public class ActivityLocation : NSObject, Mappable {
    public dynamic var Type : String? = nil
    public dynamic var Latitude : Float = 0
    public dynamic var Longitude : Float = 0
    public dynamic var Radius : Float = 0
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Type <- map["Type"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        Radius <- map["Radius"]
    }
    
}