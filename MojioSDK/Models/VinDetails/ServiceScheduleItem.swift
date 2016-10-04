//
//  ServiceScheduleItem.swift
//  Pods
//
//  Created by Ashish Agarwal on 2016-10-04.
//
//

import UIKit
import ObjectMapper
import RealmSwift

public class ServiceScheduleItem: Object, Mappable {
    
    public dynamic var TransNotes: String? = nil
    public dynamic var ScheduleName: String? = nil
    public dynamic var ScheduleDescription: String? = nil
    public dynamic var MaintenanceCategory: String? = nil
    public dynamic var MaintenanceName: String? = nil
    public dynamic var MaintenanceNotes: String? = nil
    public var Intervals = List<ServiceInterval>()
    public var Events = List<ServiceEvent>()
    
    public required convenience init?(_ map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
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
