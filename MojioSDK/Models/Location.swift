//
//  Location.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

public class LocationStatus : NSObject {
    // Status not known
    public static let Unknown : String = "Unknown"
    
    // Valid
    public static let Locked : String = "Locked"
    
    // Invalid
    public static let NotLocked : String = "NotLocked"
    
    // CalAmp Only
    // Position update has a horizontal position accuracy estimate that is less that the Horizontal
    // Position Accuracy Threshold.
    public static let Predicted : String = "Predicted"
    
    // CalAmp Only
    // WAAS DGPS is enabled and the position has been differentially corrected
    public static let DiffCorrected : String = "DiffCorrected"
    
    // CalAmp Only
    // Current GPS fix is invalid but a previous fix’s value is available.
    public static let LastKnown : String = "LastKnown"
    
    // CalAmp Only
    // T3 or fewer satellites are seen/used in the GPS fix. (i.e. with 3 satellites or less, an altitude value cannot be calculated)
    public static let TwoDFix : String = "TwoDFix"
    
    // CalAmp Only
    // Message has been logged by the device due to no network (message could not be sent to server from device).
    public static let Historic : String = "Historic"
    
    // CalAmp Only
    // Only after a power-up or reset before a valid time-sync has been obtained.
    public static let InvalidTime : String = "InvalidTime"
    
    // Xirgo Only
    // Communication Failure - Used by Xirgo
    public static let CommunicationsFailure: String = "CommunicationsFailure"
    
    // Xirgo Only
    // GPS is OFF - Used by Xirgo
    public static let GPSOff : String = "GPSOff"
    
    // Xirgo and CalAmp
    // Current GPS location is invalid and previous state's location is used
    public static let PreviousValidState : String = "PreviousValidState"
}

public class Location: Object, Mappable {
    public dynamic var LocationAddress : Address? = nil
    public dynamic var Timestamp : NSString? = nil
    public dynamic var Lat : Float = 0
    public dynamic var Lng : Float = 0
    public dynamic var Status : NSString? = nil
    public dynamic var Dilution : Float = 0
    public dynamic var Altitude : Float = 0
    public dynamic var GeoHash : NSString? = nil
    
    public required convenience init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        LocationAddress <- map["Address"];
        Timestamp <- map["Timestamp"];
        Lat <- map["Lat"];
        Lng <- map["Lng"];
        Status <- map["Status"];
        Dilution <- map["Dilution"];
        Altitude <- map["Altitude"];
        GeoHash <- map["GeoHash"];
    }

}
