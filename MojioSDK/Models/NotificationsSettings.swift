//
//  NotificationsSettings.swift
//  Pods
//
//  Created by Narayan Sainaney on 2016-06-30.
//
//

import Foundation
import ObjectMapper
import RealmSwift

public class SettingsGeofence : Mappable {
    
    public dynamic var Id : String? = nil
    public dynamic var EnableEnterActivity: Bool = false
    public dynamic var EnableExitActivity: Bool = false
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    public static func primaryKey() -> String? {
        return "Id"
    }
    
    public func mapping(map: Map) {
        Id <- map["Id"]
        EnableEnterActivity <- map["EnableEnterActivity"]
        EnableExitActivity <- map["EnableExitActivity"]
    }
}

public class NotificationsSettings :  Mappable {
    
    public var SpeedThreshold : Speed? = nil
    public dynamic var EnableTripCompletedActivity : Bool = false
    public dynamic var EnableTripStartActivity : Bool = false
    public dynamic var EnableLowFuelActivity : Bool = false
    public dynamic var EnableLowBatteryActivity : Bool = false
    public dynamic var EnableSpeedActivity : Bool = false
    public dynamic var EnableDtcActivity : Bool = false
    public dynamic var EnableCheckEngineActivity : Bool = false
    public dynamic var EnableTowActivity : Bool = false
    public dynamic var EnableMaintenanceActivity : Bool = false
    public dynamic var EnableRecallActivity : Bool = false
    public dynamic var EnableServiceBulletinActivity : Bool = false
    public dynamic var EnableDisturbanceActivity : Bool = false
    public dynamic var EnableAccidentActivity : Bool = false
    public dynamic var EnableDeviceUnpluggedActivity : Bool = false

    public dynamic var EnableGeofenceActivity : Bool = false
    public  var Geofences : [SettingsGeofence] = []
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public required init() {
        
    }
    
    public func jsonDict () -> NSDictionary {
        var dictionary = self.toJSON()
        
        if let threshold = self.SpeedThreshold {
            dictionary["SpeedThreshold"] = threshold.jsonDict()
        }
        
        var geofences: [[String: AnyObject]] = []
        for geofence in self.Geofences {
            geofences.append(geofence.toJSON())
        }
        dictionary["Geofences"] = geofences
        
        return dictionary
    }
    
    public func mapping(map: Map) {        
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