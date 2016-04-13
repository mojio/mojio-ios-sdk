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

class Location: Object, Mappable {
    dynamic var LocationAddress : Address? = nil
    dynamic var Timestamp : NSString? = nil
    dynamic var Lat : Float = 0
    dynamic var Lng : Float = 0
    dynamic var Status : NSString? = nil // ['Unknown', 'Locked', 'NotLocked', 'Predicted', 'DiffCorrected', 'LastKnown', 'TwoDFix', 'Historic', 'InvalidTime', 'CommunicationsFailure', 'GPSOff', 'PreviousValidState'],
    dynamic var Dilution : Float = 0
    dynamic var Altitude : Float = 0
    dynamic var GeoHash : NSString? = nil
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
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
