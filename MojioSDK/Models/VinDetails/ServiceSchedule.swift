//
//  ServiceSchedule.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-26.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceSchedule: Mappable {
    
    public dynamic var MaintenanceCategory : String? = nil
    public dynamic var MaintenanceName : String? = nil
    public dynamic var MaintenanceNotes : String? = nil
    public dynamic var OperatingParameter : String? = nil
    public dynamic var OperatingParameterNotes : String? = nil
    public dynamic var ScheduleDescription : String? = nil
    public dynamic var ScheduleName : String? = nil
    public dynamic var ServiceEvent : String? = nil
    public dynamic var TransNotes : String? = nil
    public dynamic var Units : String? = nil
    public dynamic var Value : Float = 0
    public dynamic var InitialValue : Float = 0
    public dynamic var IntervalType : String? = nil
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public required init() {
        
    }

    public func mapping(map: Map) {
        
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
        InitialValue <- map["InitialValue"]
        IntervalType <- map["IntervalType"]
    }
}
