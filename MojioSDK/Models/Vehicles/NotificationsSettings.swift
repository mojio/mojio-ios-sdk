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
import MojioCore

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

//public protocol NotificationSettingsModel: Codable {
//
//    associatedtype D: SpeedModel
//    associatedtype S: SettingsGeofenceModel
//
//    var speedThreshold: D? { get }
//    var enableTripCompletedActivity: Bool { get }
//    var enableTripStartActivity: Bool { get }
//
//    var enableLowFuelActivity: Bool { get }
//    var enableLowBatteryActivity: Bool { get }
//    var enableSpeedActivity: Bool { get }
//    var enableDtcActivity: Bool { get }
//    var enableCheckEngineActivity: Bool { get }
//
//    var enableTowActivity: Bool { get }
//    var enableMaintenanceActivity: Bool { get }
//    var enableRecallActivity: Bool { get }
//    var enableServiceBulletinActivity: Bool { get }
//    var enableDisturbanceActivity: Bool { get }
//    var disturbanceThreshold: DisturbanceThreshold? { get }
//    var enableAccidentActivity: Bool { get }
//    var enableDeviceUnpluggedActivity: Bool { get }
//
//    var enableVehicleConnectedActivity: Bool { get }
//    var enableDeviceUpdatedActivity: Bool { get }
//    var enableSMSActivity: Bool { get }
//    var enableVehicleCompatibilityActivity: Bool { get }
//
//    var enableGeofenceActivity: Bool { get }
//    var geofences: [S] { get }
//}
//
//public struct NotificationsSettings: NotificationSettingsModel {
//
//    public typealias D = Speed
//
//    public typealias S = SettingsGeofence
//
//    public let speedThreshold: D?
//    public let enableTripCompletedActivity: Bool
//    public let enableTripStartActivity: Bool
//
//    public let enableLowFuelActivity: Bool
//    public let enableLowBatteryActivity: Bool
//    public let enableSpeedActivity: Bool
//    public let enableDtcActivity: Bool
//    public let enableCheckEngineActivity: Bool
//
//    public let enableTowActivity: Bool
//    public let enableMaintenanceActivity: Bool
//    public let enableRecallActivity: Bool
//    public let enableServiceBulletinActivity: Bool
//    public let enableDisturbanceActivity: Bool
//    public let disturbanceThreshold: DisturbanceThreshold?
//    public let enableAccidentActivity: Bool
//    public let enableDeviceUnpluggedActivity: Bool
//
//    public let enableVehicleConnectedActivity: Bool
//    public let enableDeviceUpdatedActivity: Bool
//    public let enableSMSActivity: Bool
//    public let enableVehicleCompatibilityActivity: Bool
//
//    public let enableGeofenceActivity: Bool
//    public let geofences: [S]
//
//    public enum CodingKeys: String, CodingKey {
//        case speedThreshold = "SpeedThreshold"
//        case enableTripCompletedActivity = "EnableTripCompletedActivity"
//        case enableTripStartActivity = "EnableTripStartActivity"
//
//        case enableLowFuelActivity = "EnableLowFuelActivity"
//        case enableLowBatteryActivity = "EnableLowBatteryActivity"
//        case enableSpeedActivity = "EnableSpeedActivity"
//        case enableDtcActivity = "EnableDtcActivity"
//        case enableCheckEngineActivity = "EnableCheckEngineActivity"
//
//        case enableTowActivity = "EnableTowActivity"
//        case enableMaintenanceActivity = "EnableMaintenanceActivity"
//        case enableRecallActivity = "EnableRecallActivity"
//        case enableServiceBulletinActivity = "EnableServiceBulletinActivity"
//        case enableDisturbanceActivity = "EnableDisturbanceActivity"
//        case disturbanceThreshold = "DisturbanceThreshold"
//        case enableAccidentActivity = "EnableAccidentActivity"
//        case enableDeviceUnpluggedActivity = "EnableDeviceUnpluggedActivity"
//
//        case enableVehicleConnectedActivity = "EnableVehicleConnectedActivity"
//        case enableDeviceUpdatedActivity = "EnableDeviceUpdatedActivity"
//        case enableSMSActivity = "EnableSMSActivity"
//        case enableVehicleCompatibilityActivity = "EnableVehicleCompatibilityActivity"
//
//        case enableGeofenceActivity = "EnableGeofenceActivity"
//        case geofences = "Geofences"
//    }
//
//    public init(from decoder: Decoder) throws {
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            self.speedThreshold = try container.decodeIfPresent(Speed.self, forKey: .speedThreshold)
//            self.enableTripCompletedActivity = try container.decode(Bool.self, forKey: .enableTripCompletedActivity)
//            self.enableTripStartActivity = try container.decode(Bool.self, forKey: .enableTripStartActivity)
//
//            self.enableLowFuelActivity = try container.decode(Bool.self, forKey: .enableLowFuelActivity)
//            self.enableLowBatteryActivity = try container.decode(Bool.self, forKey: .enableLowBatteryActivity)
//            self.enableSpeedActivity = try container.decode(Bool.self, forKey: .enableSpeedActivity)
//            self.enableDtcActivity = try container.decode(Bool.self, forKey: .enableDtcActivity)
//            self.enableCheckEngineActivity = try container.decode(Bool.self, forKey: .enableCheckEngineActivity)
//
//            self.enableTowActivity = try container.decode(Bool.self, forKey: .enableTowActivity)
//            self.enableMaintenanceActivity = try container.decode(Bool.self, forKey: .enableMaintenanceActivity)
//            self.enableRecallActivity = try container.decode(Bool.self, forKey: .enableRecallActivity)
//            self.enableServiceBulletinActivity = try container.decode(Bool.self, forKey: .enableServiceBulletinActivity)
//            self.enableDisturbanceActivity = try container.decode(Bool.self, forKey: .enableDisturbanceActivity)
//            self.disturbanceThreshold = try container.decode(DisturbanceThreshold.self, forKey: .disturbanceThreshold)
//            self.enableAccidentActivity = try container.decode(Bool.self, forKey: .enableAccidentActivity)
//            self.enableDeviceUnpluggedActivity = try container.decode(Bool.self, forKey: .enableDeviceUnpluggedActivity)
//
//            self.enableVehicleConnectedActivity = try container.decode(Bool.self, forKey: .enableVehicleConnectedActivity)
//            self.enableDeviceUpdatedActivity = try container.decode(Bool.self, forKey: .enableDeviceUpdatedActivity)
//            self.enableSMSActivity = try container.decode(Bool.self, forKey: .enableSMSActivity)
//            self.enableVehicleCompatibilityActivity = try container.decode(Bool.self, forKey: .enableVehicleCompatibilityActivity)
//
//            self.enableGeofenceActivity = try container.decode(Bool.self, forKey: .enableGeofenceActivity)
//            self.geofences = try container.decodeIfPresent([SettingsGeofence].self, forKey: .geofences) ?? []
//        }
//        catch {
//            debugPrint(error)
//            throw error
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encodeIfPresent(self.speedThreshold, forKey: .speedThreshold)
//        try container.encodeIfPresent(self.enableTripCompletedActivity, forKey: .enableTripCompletedActivity)
//        try container.encodeIfPresent(self.enableTripStartActivity, forKey: .enableTripStartActivity)
//
//        try container.encodeIfPresent(self.enableLowFuelActivity, forKey: .enableLowFuelActivity)
//        try container.encodeIfPresent(self.enableLowBatteryActivity, forKey: .enableLowBatteryActivity)
//        try container.encodeIfPresent(self.enableSpeedActivity, forKey: .enableSpeedActivity)
//        try container.encodeIfPresent(self.enableDtcActivity, forKey: .enableDtcActivity)
//        try container.encodeIfPresent(self.enableCheckEngineActivity, forKey: .enableCheckEngineActivity)
//
//        try container.encodeIfPresent(self.enableTowActivity, forKey: .enableTowActivity)
//        try container.encodeIfPresent(self.enableMaintenanceActivity, forKey: .enableMaintenanceActivity)
//        try container.encodeIfPresent(self.enableRecallActivity, forKey: .enableRecallActivity)
//        try container.encodeIfPresent(self.enableServiceBulletinActivity, forKey: .enableServiceBulletinActivity)
//        try container.encodeIfPresent(self.enableDisturbanceActivity, forKey: .enableDisturbanceActivity)
//        try container.encodeIfPresent(self.disturbanceThreshold, forKey: .disturbanceThreshold)
//        try container.encodeIfPresent(self.enableAccidentActivity, forKey: .enableAccidentActivity)
//        try container.encodeIfPresent(self.enableDeviceUnpluggedActivity, forKey: .enableDeviceUnpluggedActivity)
//
//        try container.encodeIfPresent(self.enableVehicleConnectedActivity, forKey: .enableVehicleConnectedActivity)
//        try container.encodeIfPresent(self.enableDeviceUpdatedActivity, forKey: .enableDeviceUpdatedActivity)
//        try container.encodeIfPresent(self.enableSMSActivity, forKey: .enableSMSActivity)
//        try container.encodeIfPresent(self.enableVehicleCompatibilityActivity, forKey: .enableVehicleCompatibilityActivity)
//
//        try container.encodeIfPresent(self.enableGeofenceActivity, forKey: .enableGeofenceActivity)
//        try container.encodeIfPresent(self.geofences, forKey: .geofences)
//    }
//}
