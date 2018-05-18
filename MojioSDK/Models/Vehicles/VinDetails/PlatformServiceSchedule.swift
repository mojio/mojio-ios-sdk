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

import Foundation

public protocol PlatformServiceScheduleModel: Codable {
    var initialValue: Double { get }
    var intervalType: String? { get }
    var maintenanceCategory: String? { get }
    var maintenanceName: String? { get }
    var maintenanceNotes: String? { get }
    var operatingParameter: String? { get }
    var operatingParameterNotes: String? { get }
    var scheduleDescription: String? { get }
    var scheduleName: String? { get }
    var serviceEvent: String? { get }
    var transNotes: String? { get }
    var units: String? { get }
    var value: Double { get }
}

public struct PlatformServiceSchedule: PlatformServiceScheduleModel {
    
    public let initialValue: Double
    public let intervalType: String?
    public let maintenanceCategory: String?
    public let maintenanceName: String?
    public let maintenanceNotes: String?
    public let operatingParameter: String?
    public let operatingParameterNotes: String?
    public let scheduleDescription: String?
    public let scheduleName: String?
    public let serviceEvent: String?
    public let transNotes: String?
    public let units: String?
    public let value: Double
    
    public enum CodingKeys: String, CodingKey {
        case initialValue = "InitialValue"
        case intervalType = "IntervalType"
        case maintenanceCategory = "MaintenanceCategory"
        case maintenanceName = "MaintenanceName"
        case maintenanceNotes = "MaintenanceNotes"
        case operatingParameter = "OperatingParameter"
        case operatingParameterNotes = "OperatingParameterNotes"
        case scheduleDescription = "ScheduleDescription"
        case scheduleName = "ScheduleName"
        case serviceEvent = "ServiceEvent"
        case transNotes = "TransNotes"
        case units = "Units"
        case value = "Value"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.initialValue = try container.decodeIfPresent(Double.self, forKey: .initialValue) ?? 0
            
            self.intervalType = try container.decodeIfPresent(String.self, forKey: .intervalType)
            
            self.maintenanceName = try container.decodeIfPresent(String.self, forKey: .maintenanceName)
            self.maintenanceCategory = try container.decodeIfPresent(String.self, forKey: .maintenanceCategory)
            self.maintenanceNotes = try container.decodeIfPresent(String.self, forKey: .maintenanceNotes)
            
            self.operatingParameter = try container.decodeIfPresent(String.self, forKey: .operatingParameter)
            self.operatingParameterNotes = try container.decodeIfPresent(String.self, forKey: .operatingParameterNotes)
            
            self.scheduleDescription = try container.decodeIfPresent(String.self, forKey: .scheduleDescription)
            self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
            self.serviceEvent = try container.decodeIfPresent(String.self, forKey: .serviceEvent)
            self.transNotes = try container.decodeIfPresent(String.self, forKey: .transNotes)
            self.units = try container.decodeIfPresent(String.self, forKey: .units)
            self.value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.initialValue, forKey: .initialValue)
        
        try container.encodeIfPresent(self.intervalType, forKey: .intervalType)
        
        try container.encodeIfPresent(self.maintenanceCategory, forKey: .maintenanceName)
        try container.encodeIfPresent(self.maintenanceCategory, forKey: .maintenanceCategory)
        try container.encodeIfPresent(self.maintenanceNotes, forKey: .maintenanceNotes)
        
        try container.encodeIfPresent(self.operatingParameter, forKey: .operatingParameter)
        try container.encodeIfPresent(self.operatingParameterNotes, forKey: .operatingParameterNotes)
        
        try container.encodeIfPresent(self.scheduleDescription, forKey: .scheduleDescription)
        try container.encodeIfPresent(self.scheduleName, forKey: .scheduleName)
        try container.encodeIfPresent(self.serviceEvent, forKey: .serviceEvent)
        try container.encodeIfPresent(self.transNotes, forKey: .transNotes)
        try container.encodeIfPresent(self.units, forKey: .units)
        try container.encodeIfPresent(self.value, forKey: .value)
    }
}
