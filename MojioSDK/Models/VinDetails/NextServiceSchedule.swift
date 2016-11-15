//
//  NextServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class NextServiceSchedule: Mappable {

    open dynamic var TimeStamp : String? = nil
    open dynamic var Odometer : Float = 0
    open var AgeInMonths : Int? = nil
    open dynamic var TimeUnits : String? = nil
    open dynamic var TimeValue : Float = 0
    open dynamic var DistanceUnits : String? = nil
    open dynamic var DistanceValue : Float = 0
    open var Services : [PlatformServiceSchedule] = []
    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }
    
    open func mapping(map: Map) {
        
        TimeStamp <- map["TimeStamp"]
        Odometer <- map["Odometer"]
        AgeInMonths <- map["AgeInMonths"]
        TimeUnits <- map["TimeUnits"]
        TimeValue <- map["TimeValue"]
        DistanceUnits <- map["DistanceUnits"]
        DistanceValue <- map["DistanceValue"]
        Services <- map["Items"]

    }
}
