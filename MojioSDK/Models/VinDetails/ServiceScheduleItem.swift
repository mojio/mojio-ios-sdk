/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import UIKit
import ObjectMapper

public struct ServiceScheduleItem: Mappable {
    
    public var TransNotes: String? = nil
    public var ScheduleName: String? = nil
    public var ScheduleDescription: String? = nil
    public var MaintenanceCategory: String? = nil
    public var MaintenanceName: String? = nil
    public var MaintenanceNotes: String? = nil
    public var Intervals: [ServiceInterval] = []
    public var Events: [ServiceEvent] = []
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
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
