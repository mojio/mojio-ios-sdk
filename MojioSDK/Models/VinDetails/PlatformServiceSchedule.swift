//
//  PlatformServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class PlatformServiceSchedule: Mappable {
    
    open dynamic var InitialValue : Float = 0
    open dynamic var IntervalType : String? = nil
    open dynamic var MaintenanceCategory : String? = nil
    open dynamic var MaintenanceName : String? = nil
    open dynamic var MaintenanceNotes : String? = nil
    open dynamic var OperatingParameter : String? = nil
    open dynamic var OperatingParameterNotes : String? = nil
    open dynamic var ScheduleDescription : String? = nil
    open dynamic var ScheduleName : String? = nil
    open dynamic var ServiceEvent : String? = nil
    open dynamic var TransNotes : String? = nil
    open dynamic var Units : String? = nil
    open dynamic var Value : Float = 0

    
    public required convenience init?(map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {

        InitialValue <- map["InitialValue"]
        IntervalType <- map["IntervalType"]
        MaintenanceCategory <- map["MaintenanceCategory"]
        MaintenanceName <- map["MaintenanceName"]
        MaintenanceNotes <- map["MaintenanceNotes"]
        OperatingParameter <- map["OperatingParameter"]
        OperatingParameterNotes <- map["OperatingParameterNotes"]
        ScheduleDescription <- map["ScheduleDescription"]
        ScheduleName <- map["ScheduleName"]
        ServiceEvent <- map["ServiceEvent"]
        TransNotes <- map["TransNotes"]
        Units <- map["Units"]
        Value <- map["Value"]

    }

}
