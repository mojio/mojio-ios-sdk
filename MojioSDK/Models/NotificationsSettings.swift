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
import ObjectMapper

public struct SettingsGeofence: Mappable, PrimaryKey {
    
    public var Id: String? = nil
    public var EnableEnterActivity: Bool = false
    public var EnableExitActivity: Bool = false
    
    public static var primaryKey: String {
        return "Id"
    }
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public mutating func mapping(map: Map) {
        Id <- map["Id"]
        EnableEnterActivity <- map["EnableEnterActivity"]
        EnableExitActivity <- map["EnableExitActivity"]
    }
}

public struct NotificationsSettings:  Mappable {
    
    public var SpeedThreshold: Speed? = nil
    public var EnableTripCompletedActivity: Bool = false
    public var EnableTripStartActivity: Bool = false
    public var EnableLowFuelActivity: Bool = false
    public var EnableLowBatteryActivity: Bool = false
    public var EnableSpeedActivity: Bool = false
    public var EnableDtcActivity: Bool = false
    public var EnableCheckEngineActivity: Bool = false
    public var EnableTowActivity: Bool = false
    public var EnableMaintenanceActivity: Bool = false
    public var EnableRecallActivity: Bool = false
    public var EnableServiceBulletinActivity: Bool = false
    public var EnableDisturbanceActivity: Bool = false
    public var EnableAccidentActivity: Bool = false
    public var EnableDeviceUnpluggedActivity: Bool = false

    public var EnableGeofenceActivity: Bool = false
    public var Geofences: [SettingsGeofence] = []
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }
    
    public func jsonDict () -> [String: Any] {
        var map = self.toJSON()
        
        if let threshold = self.SpeedThreshold {
            map["SpeedThreshold"] = threshold.jsonDict()
        }
        
        var geofences: [[String: Any]] = []
        for geofence in self.Geofences {
            geofences.append(geofence.toJSON())
        }

        map["Geofences"] = geofences
        
        return map
    }
    
    public mutating func mapping(map: Map) {
        SpeedThreshold <- map["SpeedThreshold"]
        EnableTripStartActivity <- map["EnableTripStartActivity"]
        EnableTripCompletedActivity <- map["EnableTripCompletedActivity"]
        EnableLowFuelActivity <- map["EnableLowFuelActivity"]
        EnableLowBatteryActivity <- map["EnableLowBatteryActivity"]
        EnableSpeedActivity <- map["EnableSpeedActivity"]
        EnableDtcActivity <- map["EnableDtcActivity"]
        EnableCheckEngineActivity <- map["EnableCheckEngineActivity"]
        EnableTowActivity <- map["EnableTowActivity"]
        EnableMaintenanceActivity <- map["EnableMaintenanceActivity"]
        EnableRecallActivity <- map["EnableRecallActivity"]
        EnableServiceBulletinActivity <- map["EnableServiceBulletinActivity"]
        EnableDisturbanceActivity <- map["EnableDisturbanceActivity"]
        EnableAccidentActivity <- map["EnableAccidentActivity"]
        EnableDeviceUnpluggedActivity <- map["EnableDeviceUnpluggedActivity"]
        
        EnableGeofenceActivity <- map["EnableGeofenceActivity"]
        Geofences <- map["Geofences"]
    }
}
