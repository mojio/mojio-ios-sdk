//
//  PlatformServiceSchedule.swift
//  Motion
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class PlatformServiceSchedule: Object, Mappable {
    
    var InitialValue : Float = 0
    dynamic var IntervalType : String? = nil
    dynamic var MaintenanceCategory : String? = nil
    dynamic var MaintenanceName : String? = nil
    dynamic var MaintenanceNotes : String? = nil
    dynamic var OperatingParameter : String? = nil
    dynamic var OperatingParameterNotes : String? = nil
    dynamic var ScheduleDescription : String? = nil
    dynamic var ScheduleName : String? = nil
    dynamic var ServiceEvent : String? = nil
    dynamic var TransNotes : String? = nil
    dynamic var Units : String? = nil
    var Value : Float = 0

    
    required convenience init?(_ map: Map) {
        self.init();
    }
    
    func mapping(map: Map) {

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
