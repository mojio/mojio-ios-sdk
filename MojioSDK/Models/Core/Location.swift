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

public protocol GeneralLocation {
    
    associatedtype A: GeneralAddress
    associatedtype H: GeneralHeading
    
    var locationAddress: A? { get }
    var timestamp: Date? { get }
    var lat: Double { get }
    var lng: Double { get }
    var radius: Double { get }
    
    var status: String? { get }
    var dilution: Double { get }
    var altitude: Double { get }
    var geoHash: String? { get }
    
    var locationHeading: H? { get }
}

public struct Location: Codable, GeneralLocation {
    
    public typealias A = Address
    public typealias H = Heading
    
    public let locationAddress: A?
    public let timestamp: Date?
    public let lat: Double
    public let lng: Double
    public let radius: Double
    
    // LocationStatus
    public let status: String?
    public let dilution: Double
    public let altitude: Double
    public let geoHash: String?
    
    // Heading
    public let locationHeading: H?
    
    public enum CodingKeys: String, CodingKey {
        case locationAddress = "Address"
        case timestamp = "Timestamp"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
        case status = "Status"
        case dilution = "Dilution"
        case altitude = "Altitude"
        case geoHash = "GeoHash"
        case locationHeading = "Heading"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.locationAddress = try container.decodeIfPresent(Address.self, forKey: .locationAddress)
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            
            self.lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0
            self.lng = try container.decodeIfPresent(Double.self, forKey: .lng) ?? 0
            
            self.radius = try container.decodeIfPresent(Double.self, forKey: .radius) ?? 0
            self.status = try container.decodeIfPresent(String.self, forKey: .status)
            
            self.dilution = try container.decodeIfPresent(Double.self, forKey: .dilution) ?? 0
            self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude) ?? 0
            self.geoHash = try container.decodeIfPresent(String.self, forKey: .geoHash)
            self.locationHeading = try container.decodeIfPresent(Heading.self, forKey: .locationHeading)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
