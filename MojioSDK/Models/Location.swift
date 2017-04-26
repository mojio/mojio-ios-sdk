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

import UIKit
import ObjectMapper

public enum LocationStatus: String {
    // Status not known
    case unknown = "Unknown"
    
    // Valid
    case locked = "Locked"
    
    // Invalid
    case notLocked = "NotLocked"
    
    // CalAmp Only
    // Position update has a horizontal position accuracy estimate that is less that the Horizontal
    // Position Accuracy Threshold.
    case predicted = "Predicted"
    
    // CalAmp Only
    // WAAS DGPS is enabled and the position has been differentially corrected
    case diffCorrected = "DiffCorrected"
    
    // CalAmp Only
    // Current GPS fix is invalid but a previous fix’s value is available.
    case lastKnown = "LastKnown"
    
    // CalAmp Only
    // T3 or fewer satellites are seen/used in the GPS fix. (i.e. with 3 satellites or less, an altitude value cannot be calculated)
    case twoDFix = "TwoDFix"
    
    // CalAmp Only
    // Message has been logged by the device due to no network (message could not be sent to server from device).
    case historic = "Historic"
    
    // CalAmp Only
    // Only after a power-up or reset before a valid time-sync has been obtained.
    case invalidTime = "InvalidTime"
    
    // Xirgo Only
    // Communication Failure - Used by Xirgo
    case communicationsFailure = "CommunicationsFailure"
    
    // Xirgo Only
    // GPS is OFF - Used by Xirgo
    case gpsOff = "GPSOff"
    
    // Xirgo and CalAmp
    // Current GPS location is invalid and previous state's location is used
    case previousValidState = "PreviousValidState"
}

public struct Location: Mappable {
    public var LocationAddress: Address? = nil
    public var Timestamp: String? = nil
    public var Lat: Double = 0
    public var Lng: Double = 0
    public var Radius: Double = 0
    
    // LocationStatus
    public var Status: String? = nil
    public var Dilution: Double = 0
    public var Altitude: Double = 0
    public var GeoHash: String? = nil
    
    // Date Values
    public var timestamp: Date? = nil
    
    public init() {}
    
    public init?(map: Map) {
        self.init()
    }

    public mutating func mapping(map: Map) {
        LocationAddress <- map["Address"]
        Timestamp <- map["Timestamp"]
        Lat <- map["Lat"]
        Lng <- map["Lng"]
        Status <- map["Status"]
        Dilution <- map["Dilution"]
        Altitude <- map["Altitude"]
        GeoHash <- map["GeoHash"]
        
        // Date Values
        timestamp = self.Timestamp?.toDate
    }
}
