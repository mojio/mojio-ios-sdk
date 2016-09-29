//
//  NextServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

public class NextServiceSchedule: Mappable {

    public dynamic var TimeStamp : String? = nil
    public dynamic var Odometer : Float = 0
    public var AgeInMonths : Int? = nil
    public dynamic var TimeUnits : String? = nil
    public dynamic var TimeValue : Float = 0
    public dynamic var DistanceUnits : String? = nil
    public dynamic var DistanceValue : Float = 0
    public var Services : [PlatformServiceSchedule] = []
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }
    
    public func mapping(map: Map) {
        
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
