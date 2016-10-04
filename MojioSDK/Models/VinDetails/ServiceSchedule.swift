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

public class ServiceSchedule: Object, Mappable {
    
    public dynamic var TransNotes : String? = nil
    public dynamic var ScheduleName : String? = nil
    public dynamic var ScheduleDescription : String? = nil
    public dynamic var MaintenanceCategory : String? = nil
    public dynamic var MaintenanceName : String? = nil
    public dynamic var MaintenanceNotes : String? = nil
    
    public var Intervals = List<ServiceInterval>()
    public var Events = List<ServiceEvent>()
    
    public required convenience init?(_ map: Map) {
        self.init();
    }
    
    public func mapping(map: Map) {
        
        MaintenanceCategory <- map["MaintenanceCategory"]
        MaintenanceName <- map["MaintenanceName"]
        MaintenanceNotes <- map["MaintenanceNotes"]
        ScheduleDescription <- map["ScheduleDescription"]
        ScheduleName <- map["ScheduleName"]
        TransNotes <- map["TransNotes"]
        
        var events = Array<ServiceEvent>()
        events <- map["Events"]
        
        for event in events {
            self.Events.append(event)
        }
        
        var intervals = Array<ServiceInterval>()
        intervals <- map["Intervals"]
        
        for interval in intervals {
            self.Intervals.append(interval)
        }
    }
}
