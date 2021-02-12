/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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
import MojioCore

public typealias SpeedThresholdModel = DeviceMeasurement

public struct SpeedThreshold: SpeedThresholdModel {
    
    public typealias U = SpeedUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
}

extension SpeedThreshold {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(baseUnit: deviceMeasurements.baseUnit ?? .unknown, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit ?? .unknown, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp)
    }
    
    public func encode(with encoder: Encoder) throws {
        
    }
}

public enum DisturbanceThreshold: String, Codable {
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = DisturbanceThreshold(rawValue: label) ?? .unknown
    }
    
    public static var all: [DisturbanceThreshold] {
        return [.low, .medium, .high]
    }
}

public enum LowFuelActivityMode: String, Codable {
    case low = "Low"
    case intelligent = "Intelligent"
}

public protocol VehicleActivitySettingsModel: Codable {
    associatedtype S: SpeedThresholdModel
    
    var enableTripStartActivity: Bool? { get }
    var enableTripCompletedActivity: Bool? { get }
    var enableLowFuelActivity: Bool? { get }
    var enableLowBatteryActivity: Bool? { get }
    var enableSpeedActivity: Bool? { get }
    var enableDtcActivity: Bool? { get }
    var enableCheckEngineActivity: Bool? { get }
    var enableTowActivity: Bool? { get }
    var enableMaintenanceActivity: Bool? { get }
    var enableRecallActivity: Bool? { get }
    var enableServiceBulletinActivity: Bool? { get }
    var enableDisturbanceActivity: Bool? { get }
    var disturbanceThreshold: String? { get }
    var enableAccidentActivity: Bool? { get }
    var enableDeviceUnpluggedActivity: Bool? { get }
    var enableVehicleConnectedActivity: Bool? { get }
    var enableDeviceUpdatedActivity: Bool? { get }
    var enableSMSActivity: Bool? { get }
    var enableVehicleCompatibilityActivity: Bool? { get }
    var speedThreshold: S? { get }
    var lowFuelActivityMode: LowFuelActivityMode? { get }
    
    var enableMainFirmwareCompatibilityActivity: Bool? { get }
    var enableHardwareVersionCompatibilityActivity: Bool? { get }
    var enableServiceScheduleActivity: Bool? { get }
    var enableSeatbeltDisengagedActivity: Bool? { get }
    var enableSeatbeltEngagedActivity: Bool? { get }
    var enableDriverSeatbeltDisengagedActivity: Bool? { get }
    var enableDriverSeatbeltEngagedActivity: Bool? { get }
    var enablePassengerSeatbeltDisengagedActivity: Bool? { get }
    var enablePassengerSeatbeltEngagedActivity: Bool? { get }
    var enableEngineOilLevelWarningActivity: Bool? { get }
    var enableEngineOilPressureLowWarningActivity: Bool? { get }
    var enableTirePressureWarningActivity: Bool? { get }
    var enableAirFilterMaintenanceActivity: Bool? { get }
    var enableLowBrakeFluidWarningActivity: Bool? { get }
    var enableMaintenanceReminderActivity: Bool? { get }
}

public struct VehicleActivitySettings: VehicleActivitySettingsModel {
    
    public typealias S = SpeedThreshold
    
    public let enableTripStartActivity: Bool?
    public let enableTripCompletedActivity: Bool?
    public let enableLowFuelActivity: Bool?
    public let enableLowBatteryActivity: Bool?
    public let enableSpeedActivity: Bool?
    public let enableDtcActivity: Bool?
    public let enableCheckEngineActivity: Bool?
    public let enableTowActivity: Bool?
    public let enableMaintenanceActivity: Bool?
    public let enableRecallActivity: Bool?
    public let enableServiceBulletinActivity: Bool?
    public let enableDisturbanceActivity: Bool?
    public let disturbanceThreshold: String?
    public let enableAccidentActivity: Bool?
    public let enableDeviceUnpluggedActivity: Bool?
    public let enableVehicleConnectedActivity: Bool?
    public let enableDeviceUpdatedActivity: Bool?
    public let enableSMSActivity: Bool?
    public let enableVehicleCompatibilityActivity: Bool?
    public let speedThreshold: SpeedThreshold?
    public let lowFuelActivityMode: LowFuelActivityMode?
    
    public let enableMainFirmwareCompatibilityActivity: Bool?
    public let enableHardwareVersionCompatibilityActivity: Bool?
    public let enableServiceScheduleActivity: Bool?
    public let enableSeatbeltDisengagedActivity: Bool?
    public let enableSeatbeltEngagedActivity: Bool?
    public let enableDriverSeatbeltDisengagedActivity: Bool?
    public let enableDriverSeatbeltEngagedActivity: Bool?
    public let enablePassengerSeatbeltDisengagedActivity: Bool?
    public let enablePassengerSeatbeltEngagedActivity: Bool?
    public let enableEngineOilLevelWarningActivity: Bool?
    public let enableEngineOilPressureLowWarningActivity: Bool?
    public let enableTirePressureWarningActivity: Bool?
    public let enableAirFilterMaintenanceActivity: Bool?
    public let enableLowBrakeFluidWarningActivity: Bool?
    public let enableMaintenanceReminderActivity: Bool?

    public enum CodingKeys: String, CodingKey {
        case enableTripStartActivity
        case enableTripCompletedActivity
        case enableLowFuelActivity
        case enableLowBatteryActivity
        case enableSpeedActivity
        case enableDtcActivity
        case enableCheckEngineActivity
        case enableTowActivity
        case enableMaintenanceActivity
        case enableRecallActivity
        case enableServiceBulletinActivity
        case enableDisturbanceActivity
        case disturbanceThreshold
        case enableAccidentActivity
        case enableDeviceUnpluggedActivity
        case enableVehicleConnectedActivity
        case enableDeviceUpdatedActivity
        case enableSMSActivity
        case enableVehicleCompatibilityActivity
        case speedThreshold
        case lowFuelActivityMode
        
        case enableMainFirmwareCompatibilityActivity
        case enableHardwareVersionCompatibilityActivity
        case enableServiceScheduleActivity
        case enableSeatbeltDisengagedActivity
        case enableSeatbeltEngagedActivity
        case enableDriverSeatbeltDisengagedActivity
        case enableDriverSeatbeltEngagedActivity
        case enablePassengerSeatbeltDisengagedActivity
        case enablePassengerSeatbeltEngagedActivity
        case enableEngineOilLevelWarningActivity
        case enableEngineOilPressureLowWarningActivity
        case enableTirePressureWarningActivity
        case enableAirFilterMaintenanceActivity 
        case enableLowBrakeFluidWarningActivity
        case enableMaintenanceReminderActivity
    }
}
