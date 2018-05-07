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
import CoreLocation

public enum LocationType: String, Codable {
    case place = "Place"
    case activityLocation = "ActivityLocation"
}

public struct PetsLocation: Codable {
    public let latitude: Double?
    public let longitude: Double?
    public let altitude: Double?
    public let timestamp: Date?
    public let heading: Double?
    public let hError: Double?
    public let vError: Double?
    public let type: LocationType?
    public let name: String?
    
    public enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case altitude = "Altitude"
        case timestamp = "Timestamp"
        case heading = "Heading"
        case hError = "HError"
        case vError = "VError"
        case type = "Type"
        case name = "Name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
            self.altitude = try container.decodeIfPresent(Double.self, forKey: .altitude)
            self.timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
            self.heading = try container.decodeIfPresent(Double.self, forKey: .heading)
            self.hError = try container.decodeIfPresent(Double.self, forKey: .hError)
            self.vError = try container.decodeIfPresent(Double.self, forKey: .vError)
            self.type = try container.decodeIfPresent(LocationType.self, forKey: .type)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public extension PetsLocation {
    init(coreLocation: CLLocation, coreHeading: CLHeading? = nil) {
        self.latitude = coreLocation.coordinate.latitude
        self.longitude = coreLocation.coordinate.longitude
        self.altitude = coreLocation.altitude
        self.heading = coreHeading?.trueHeading ?? 0
        self.timestamp = coreLocation.timestamp
        self.hError = coreLocation.horizontalAccuracy
        self.vError = coreLocation.verticalAccuracy
        self.name = nil
        self.type = nil
    }
}

public extension PetsLocation {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
