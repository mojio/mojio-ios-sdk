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

public struct SettingsGeofence: Codable, PrimaryKey {
    
    public let id: String
    public let enableEnterActivity: Bool
    public let enableExitActivity: Bool
    
    public enum CodingKeys: String, CodingKey {
        case id = "Id"
        case enableEnterActivity = "EnableEnterActivity"
        case enableExitActivity = "EnableExitActivity"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.enableEnterActivity = try container.decode(Bool.self, forKey: .enableEnterActivity)
            self.enableExitActivity = try container.decode(Bool.self, forKey: .enableExitActivity)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct NotificationsSettings: Codable {
    
    public let speedThreshold: Speed?
    public let enableTripCompletedActivity: Bool
    public let enableTripStartActivity: Bool
    
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
    public let disturbanceThreshold: DisturbanceThreshold?
    public let enableAccidentActivity: Bool
    public let enableDeviceUnpluggedActivity: Bool
    
    public let enableVehicleConnectedActivity: Bool
    public let enableDeviceUpdatedActivity: Bool
    public let enableSMSActivity: Bool
    public let enableVehicleCompatibilityActivity: Bool
    
    public let enableGeofenceActivity: Bool
    public let geofences: [SettingsGeofence]
    
    public enum CodingKeys: String, CodingKey {
        case speedThreshold = "SpeedThreshold"
        case enableTripCompletedActivity = "EnableTripCompletedActivity"
        case enableTripStartActivity = "EnableTripStartActivity"
        
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

        case enableGeofenceActivity = "EnableGeofenceActivity"
        case geofences = "Geofences"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.speedThreshold = try container.decodeIfPresent(Speed.self, forKey: .speedThreshold)
            self.enableTripCompletedActivity = try container.decode(Bool.self, forKey: .enableTripCompletedActivity)
            self.enableTripStartActivity = try container.decode(Bool.self, forKey: .enableTripStartActivity)
            
            self.enableLowFuelActivity = try container.decode(Bool.self, forKey: .enableLowFuelActivity)
            self.enableLowBatteryActivity = try container.decode(Bool.self, forKey: .enableLowBatteryActivity)
            self.enableSpeedActivity = try container.decode(Bool.self, forKey: .enableSpeedActivity)
            self.enableDtcActivity = try container.decode(Bool.self, forKey: .enableDtcActivity)
            self.enableCheckEngineActivity = try container.decode(Bool.self, forKey: .enableCheckEngineActivity)

            self.enableTowActivity = try container.decode(Bool.self, forKey: .enableTowActivity)
            self.enableMaintenanceActivity = try container.decode(Bool.self, forKey: .enableMaintenanceActivity)
            self.enableRecallActivity = try container.decode(Bool.self, forKey: .enableRecallActivity)
            self.enableServiceBulletinActivity = try container.decode(Bool.self, forKey: .enableServiceBulletinActivity)
            self.enableDisturbanceActivity = try container.decode(Bool.self, forKey: .enableDisturbanceActivity)
            self.disturbanceThreshold = try container.decode(DisturbanceThreshold.self, forKey: .disturbanceThreshold)
            self.enableAccidentActivity = try container.decode(Bool.self, forKey: .enableAccidentActivity)
            self.enableDeviceUnpluggedActivity = try container.decode(Bool.self, forKey: .enableDeviceUnpluggedActivity)

            self.enableVehicleConnectedActivity = try container.decode(Bool.self, forKey: .enableVehicleConnectedActivity)
            self.enableDeviceUpdatedActivity = try container.decode(Bool.self, forKey: .enableDeviceUpdatedActivity)
            self.enableSMSActivity = try container.decode(Bool.self, forKey: .enableSMSActivity)
            self.enableVehicleCompatibilityActivity = try container.decode(Bool.self, forKey: .enableVehicleCompatibilityActivity)
            
            self.enableGeofenceActivity = try container.decode(Bool.self, forKey: .enableGeofenceActivity)
            self.geofences = try container.decodeIfPresent([SettingsGeofence].self, forKey: .geofences) ?? []
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
