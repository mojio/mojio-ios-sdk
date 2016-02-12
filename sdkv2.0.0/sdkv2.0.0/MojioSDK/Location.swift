//
//  Location.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

class Location: Mappable {
    var LocationAddress : Address?;
    var Timestamp : NSString?;
    var Lat : NSNumber?;
    var Lng  : NSNumber?;
    var Status : NSString?; // ['Unknown', 'Locked', 'NotLocked', 'Predicted', 'DiffCorrected', 'LastKnown', 'TwoDFix', 'Historic', 'InvalidTime', 'CommunicationsFailure', 'GPSOff', 'PreviousValidState'],
    var Dilution  : NSNumber?;
    var Altitude  : NSNumber?;
    var GeoHash : NSString?;
    
    required init?(_ map: Map) {
        
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
