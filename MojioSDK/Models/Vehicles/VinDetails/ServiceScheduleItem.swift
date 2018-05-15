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

public protocol ServiceScheduleItemModel: Codable {
    
    associatedtype I: ServiceIntervalModel
    associatedtype E: ServiceEventModel
    
    var transNotes: String? { get }
    var scheduleName: String? { get }
    var scheduleDescription: String? { get }
    var maintenanceCategory: String? { get }
    var maintenanceName: String? { get }
    var maintenanceNotes: String? { get }
    var intervals: [I] { get }
    var events: [E] { get }
}

public struct ServiceScheduleItem: ServiceScheduleItemModel {
    
    public typealias I = ServiceInterval
    public typealias E = ServiceEvent
    
    public let transNotes: String?
    public let scheduleName: String?
    public let scheduleDescription: String?
    public let maintenanceCategory: String?
    public let maintenanceName: String?
    public let maintenanceNotes: String?
    public let intervals: [I]
    public let events: [E]
    
    public enum CodingKeys: String, CodingKey {
        case transNotes = "TransNotes"
        case scheduleName = "ScheduleName"
        case scheduleDescription = "ScheduleDescription"
        case maintenanceCategory = "MaintenanceCategory"
        case maintenanceName = "MaintenanceName"
        case maintenanceNotes = "MaintenanceNotes"
        case intervals = "Intervals"
        case events = "Events"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.transNotes = try container.decodeIfPresent(String.self, forKey: .transNotes)
            self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
            self.scheduleDescription = try container.decodeIfPresent(String.self, forKey: .scheduleDescription)
            
            self.maintenanceCategory = try container.decodeIfPresent(String.self, forKey: .maintenanceCategory)
            self.maintenanceName = try container.decodeIfPresent(String.self, forKey: .maintenanceName)
            self.maintenanceNotes = try container.decodeIfPresent(String.self, forKey: .maintenanceNotes)
            
            self.intervals = try container.decodeIfPresent([ServiceInterval].self, forKey: .intervals) ?? []
            self.events = try container.decodeIfPresent([ServiceEvent].self, forKey: .events) ?? []
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
