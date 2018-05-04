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

public struct PlatformServiceSchedule: Codable {
    
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
}
