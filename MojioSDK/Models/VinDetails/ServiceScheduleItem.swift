//
//  ServiceScheduleItem.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper

open class ServiceScheduleItem: Mappable {
    
    open dynamic var TransNotes: String? = nil
    open dynamic var ScheduleName: String? = nil
    open dynamic var ScheduleDescription: String? = nil
    open dynamic var MaintenanceCategory: String? = nil
    open dynamic var MaintenanceName: String? = nil
    open dynamic var MaintenanceNotes: String? = nil
    open var Intervals : [ServiceInterval] = []
    open var Events : [ServiceEvent] = []
    
    public required convenience init?(map: Map) {
        self.init()
    }

    open func mapping(map: Map) {
        
        TransNotes <- map["TransNotes"]
        ScheduleName <- map["ScheduleName"]
        ScheduleDescription <- map["ScheduleDescription"]
        MaintenanceCategory <- map["MaintenanceCategory"]
        MaintenanceName <- map["MaintenanceName"]
        MaintenanceNotes <- map["MaintenanceNotes"]
        Intervals <- map["Intervals"]
        Events <- map["Events"]
    }

}
