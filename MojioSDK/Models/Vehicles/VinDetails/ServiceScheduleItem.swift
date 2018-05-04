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

public struct ServiceScheduleItem: Codable {
    
    public let transNotes: String?
    public let scheduleName: String?
    public let scheduleDescription: String?
    public let maintenanceCategory: String?
    public let maintenanceName: String?
    public let maintenanceNotes: String?
    public let intervals: [ServiceInterval]
    public let events: [ServiceEvent]
    
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
}
