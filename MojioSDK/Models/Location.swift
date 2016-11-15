//
//  Location.swift
//  MojioSDK
//
//  Created by Ashish Agarwal on 2016-02-11.
//  Copyright © 2016 Mojio. All rights reserved.
//

import UIKit
import ObjectMapper

open class LocationStatus : NSObject {
    // Status not known
    open static let Unknown : String = "Unknown"
    
    // Valid
    open static let Locked : String = "Locked"
    
    // Invalid
    open static let NotLocked : String = "NotLocked"
    
    // CalAmp Only
    // Position update has a horizontal position accuracy estimate that is less that the Horizontal
    // Position Accuracy Threshold.
    open static let Predicted : String = "Predicted"
    
    // CalAmp Only
    // WAAS DGPS is enabled and the position has been differentially corrected
    open static let DiffCorrected : String = "DiffCorrected"
    
    // CalAmp Only
    // Current GPS fix is invalid but a previous fix’s value is available.
    open static let LastKnown : String = "LastKnown"
    
    // CalAmp Only
    // T3 or fewer satellites are seen/used in the GPS fix. (i.e. with 3 satellites or less, an altitude value cannot be calculated)
    open static let TwoDFix : String = "TwoDFix"
    
    // CalAmp Only
    // Message has been logged by the device due to no network (message could not be sent to server from device).
    open static let Historic : String = "Historic"
    
    // CalAmp Only
    // Only after a power-up or reset before a valid time-sync has been obtained.
    open static let InvalidTime : String = "InvalidTime"
    
    // Xirgo Only
    // Communication Failure - Used by Xirgo
    open static let CommunicationsFailure: String = "CommunicationsFailure"
    
    // Xirgo Only
    // GPS is OFF - Used by Xirgo
    open static let GPSOff : String = "GPSOff"
    
    // Xirgo and CalAmp
    // Current GPS location is invalid and previous state's location is used
    open static let PreviousValidState : String = "PreviousValidState"
}

open class Location: Mappable {
    open var LocationAddress : Address? = nil
    open dynamic var Timestamp : String? = nil
    open dynamic var Lat : Float = 0
    open dynamic var Lng : Float = 0
    open dynamic var Radius : Float = 0
    
    // LocationStatus
    open dynamic var Status : String? = nil
    open dynamic var Dilution : Float = 0
    open dynamic var Altitude : Float = 0
    open dynamic var GeoHash : String? = nil
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public required init() {
        
    }

    open func mapping(map: Map) {
        LocationAddress <- map["Address"]
        Timestamp <- map["Timestamp"]
        Lat <- map["Lat"]
        Lng <- map["Lng"]
        Status <- map["Status"]
        Dilution <- map["Dilution"]
        Altitude <- map["Altitude"]
        GeoHash <- map["GeoHash"]
    }

}
