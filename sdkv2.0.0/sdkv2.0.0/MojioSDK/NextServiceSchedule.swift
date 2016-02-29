//
//  NextServiceSchedule.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class NextServiceSchedule: Object, Mappable {

    dynamic var TimeStamp : String? = nil
    var Odometer : Float = 0
    var AgeInMonths = RealmOptional<Int>()
    dynamic var TimeUnits : String? = nil
    var TimeValue : Float = 0
    dynamic var DistanceUnits : String? = nil
    var DistanceValue : Float = 0
    var Services = List<PlatformServiceSchedule>()
    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {
        
        var services = Array<PlatformServiceSchedule>()
        services <- map["Services"]
        
        for service in services {
            self.Services.append(service)
        }
        
        TimeStamp <- map["TimeStamp"]
        Odometer <- map["Odometer"]
        AgeInMonths <- map["AgeInMonths"]
        TimeUnits <- map["TimeUnits"]
        TimeValue <- map["TimeValue"]
        DistanceUnits <- map["DistanceUnits"]
        DistanceValue <- map["DistanceValue"]
    }
}
