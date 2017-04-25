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

public struct PlatformServiceSchedule: Mappable {
    
    public var InitialValue: Double = 0
    public var IntervalType: String? = nil
    public var MaintenanceCategory: String? = nil
    public var MaintenanceName: String? = nil
    public var MaintenanceNotes: String? = nil
    public var OperatingParameter: String? = nil
    public var OperatingParameterNotes: String? = nil
    public var ScheduleDescription: String? = nil
    public var ScheduleName: String? = nil
    public var ServiceEvent: String? = nil
    public var TransNotes: String? = nil
    public var Units: String? = nil
    public var Value: Double = 0
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
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
