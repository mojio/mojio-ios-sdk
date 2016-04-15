//
//  Location.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class Location: Object, Mappable {
    public dynamic var LocationAddress : Address? = nil
    public dynamic var Timestamp : NSString? = nil
    public dynamic var Lat : Float = 0
    public dynamic var Lng : Float = 0
    public dynamic var Status : NSString? = nil // ['Unknown', 'Locked', 'NotLocked', 'Predicted', 'DiffCorrected', 'LastKnown', 'TwoDFix', 'Historic', 'InvalidTime', 'CommunicationsFailure', 'GPSOff', 'PreviousValidState'],
    public dynamic var Dilution : Float = 0
    public dynamic var Altitude : Float = 0
    public dynamic var GeoHash : NSString? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        LocationAddress <- map["Address"];
        Timestamp <- map["Timestamp"];
        Lat <- map["Lat"];
        Lng <- map["Lng"];
        Status <- map["Status"];
        Dilution <- map["Dilution"];
        Altitude <- map["Altitude"];
        GeoHash <- map["GeoHash"];
    }

}
