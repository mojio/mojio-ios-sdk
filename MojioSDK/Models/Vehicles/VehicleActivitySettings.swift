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

public protocol SpeedThresholdModel: Codable {
    var baseUnit: String { get }
    var timestamp: String { get }
    var baseValue: Int { get }
    var unit: String { get }
    var value: Int { get }
}

public protocol VehicleActivitySettingsModel: Codable {
    associatedtype S: SpeedThresholdModel
    
    var enableTripStartActivity: Bool { get }
    var enableTripCompletedActivity: Bool { get }
    var enableLowFuelActivity: Bool { get }
    var enableLowBatteryActivity: Bool { get }
    var enableSpeedActivity: Bool { get }
    var enableDtcActivity: Bool { get }
    var enableCheckEngineActivity: Bool { get }
    var enableTowActivity: Bool { get }
    var enableMaintenanceActivity: Bool { get }
    var enableRecallActivity: Bool { get }
    var enableServiceBulletinActivity: Bool { get }
    var enableDisturbanceActivity: Bool { get }
    var disturbanceThreshold: String { get }
    var enableAccidentActivity: Bool { get }
    var enableDeviceUnpluggedActivity: Bool { get }
    var enableVehicleConnectedActivity: Bool { get }
    var enableDeviceUpdatedActivity: Bool { get }
    var enableSMSActivity: Bool { get }
    var enableVehicleCompatibilityActivity: Bool { get }
    var speedThreshold: S { get }
}

public struct SpeedThreshold: SpeedThresholdModel {
    public let baseUnit: String
    public let timestamp: String
    public let baseValue: Int
    public let unit: String
    public let value: Int
    
    public enum CodingKeys: String, CodingKey {
        case baseUnit = "BaseUnit"
        case timestamp = "Timestamp"
        case baseValue = "BaseValue"
        case unit = "Unit"
        case value = "Value"
    }
}

public struct VehicleActivitySettings: VehicleActivitySettingsModel {
    public typealias S = SpeedThreshold
    
    public let enableTripStartActivity: Bool
    public let enableTripCompletedActivity: Bool
    public let enableLowFuelActivity: Bool
    public let enableLowBatteryActivity: Bool
    public let enableSpeedActivity: Bool
    public let enableDtcActivity: Bool
    public let enableCheckEngineActivity: Bool
    public let enableTowActivity: Bool
    public let enableMaintenanceActivity: Bool
    public let enableRecallActivity: Bool
    public let enableServiceBulletinActivity: Bool
    public let enableDisturbanceActivity: Bool
    public let disturbanceThreshold: String
    public let enableAccidentActivity: Bool
    public let enableDeviceUnpluggedActivity: Bool
    public let enableVehicleConnectedActivity: Bool
    public let enableDeviceUpdatedActivity: Bool
    public let enableSMSActivity: Bool
    public let enableVehicleCompatibilityActivity: Bool
    public let speedThreshold: SpeedThreshold
    
    public enum CodingKeys: String, CodingKey {
        case enableTripStartActivity = "EnableTripStartActivity"
        case enableTripCompletedActivity = "EnableTripCompletedActivity"
        case enableLowFuelActivity = "EnableLowFuelActivity"
        case enableLowBatteryActivity = "EnableLowBatteryActivity"
        case enableSpeedActivity = "EnableSpeedActivity"
        case enableDtcActivity = "EnableDtcActivity"
        case enableCheckEngineActivity = "EnableCheckEngineActivity"
        case enableTowActivity = "EnableTowActivity"
        case enableMaintenanceActivity = "EnableMaintenanceActivity"
        case enableRecallActivity = "EnableRecallActivity"
        case enableServiceBulletinActivity = "EnableServiceBulletinActivity"
        case enableDisturbanceActivity = "EnableDisturbanceActivity"
        case disturbanceThreshold = "DisturbanceThreshold"
        case enableAccidentActivity = "EnableAccidentActivity"
        case enableDeviceUnpluggedActivity = "EnableDeviceUnpluggedActivity"
        case enableVehicleConnectedActivity = "EnableVehicleConnectedActivity"
        case enableDeviceUpdatedActivity = "EnableDeviceUpdatedActivity"
        case enableSMSActivity = "EnableSMSActivity"
        case enableVehicleCompatibilityActivity = "EnableVehicleCompatibilityActivity"
        case speedThreshold = "SpeedThreshold"
    }
}
