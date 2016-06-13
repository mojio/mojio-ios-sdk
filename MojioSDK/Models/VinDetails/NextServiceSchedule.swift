//
//  NextServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class NextServiceSchedule: Object, Mappable {

    public dynamic var TimeStamp : String? = nil
    public dynamic var Odometer : Float = 0
    public var AgeInMonths = RealmOptional<Int>()
    public dynamic var TimeUnits : String? = nil
    public dynamic var TimeValue : Float = 0
    public dynamic var DistanceUnits : String? = nil
    public dynamic var DistanceValue : Float = 0
    public var Services = List<PlatformServiceSchedule>()
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func AgeInMonthsAsIntNumber() -> NSNumber? {
        return self.AgeInMonths.value as? NSNumber
    }
    
    public func ServicesArray() -> NSArray {
        return self.Services.toArray()
    }
    
    public func mapping(map: Map) {
        
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
