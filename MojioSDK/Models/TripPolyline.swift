//
//  TripPolyline.swift
//  MojioSDK
//
//  Created by Suresh Venkatraman on 11/15/16.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper

public class TripPolyline: Mappable {
    
    public dynamic var Id : String? = nil
    public dynamic var TripPolyline : String? = nil
    public dynamic var CreatedOn : String? = nil
    public dynamic var LastModified : String? = nil
    public dynamic var Deleted : Bool = false
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        TripPolyline <- map["Polyline"]
        CreatedOn <- map["CreatedOn"]
        LastModified <- map["LastModified"]
        Deleted <- map["Deleted"]
    }
    
}
