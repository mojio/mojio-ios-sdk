//
//  NotificationsSettings.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-30.
//
//

import Foundation
import ObjectMapper

open class SettingsGeofence : Mappable {
    
    open dynamic var Id : String? = nil
    open dynamic var EnableEnterActivity: Bool = false
    open dynamic var EnableExitActivity: Bool = false
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open static func primaryKey() -> String? {
        return "Id"
    }
    
    open func mapping(map: Map) {
        Id <- map["Id"]
        EnableEnterActivity <- map["EnableEnterActivity"]
        EnableExitActivity <- map["EnableExitActivity"]
    }
}

open class NotificationsSettings :  Mappable {
    
    open var SpeedThreshold : Speed? = nil
    open dynamic var EnableTripCompletedActivity : Bool = false
    open dynamic var EnableTripStartActivity : Bool = false
    open dynamic var EnableLowFuelActivity : Bool = false
    open dynamic var EnableLowBatteryActivity : Bool = false
    open dynamic var EnableSpeedActivity : Bool = false
    open dynamic var EnableDtcActivity : Bool = false
    open dynamic var EnableCheckEngineActivity : Bool = false
    open dynamic var EnableTowActivity : Bool = false
    open dynamic var EnableMaintenanceActivity : Bool = false
    open dynamic var EnableRecallActivity : Bool = false
    open dynamic var EnableServiceBulletinActivity : Bool = false
    open dynamic var EnableDisturbanceActivity : Bool = false
    open dynamic var EnableAccidentActivity : Bool = false
    open dynamic var EnableDeviceUnpluggedActivity : Bool = false

    open dynamic var EnableGeofenceActivity : Bool = false
    open  var Geofences : [SettingsGeofence] = []
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    open func jsonDict () -> [String: Any] {
        var dictionary = self.toJSON()
        
        if let threshold = self.SpeedThreshold {
            dictionary["SpeedThreshold"] = threshold.jsonDict()
        }
        
        var geofences: [[String: Any]] = []
        for geofence in self.Geofences {
            geofences.append(geofence.toJSON())
        }
        dictionary["Geofences"] = geofences
        
        return dictionary
    }
    
    open func mapping(map: Map) {        
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
