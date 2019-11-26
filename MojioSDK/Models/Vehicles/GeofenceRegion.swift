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
import MojioCore

public enum GeofenceRegionType: String, Codable {
    case circle = "Circle"
    case polygon = "Polygon"
}

public protocol GeofenceRegionModel: Codable {
    
    associatedtype D: DistanceModel
    
    var type: GeofenceRegionType? { get }
    var latitude: Double? { get }
    var longitude: Double? { get }
    var radius: D? { get }
    var polygon: String?  { get }
}

public struct GeofenceRegion: GeofenceRegionModel {
    
    public typealias D = Distance
    
    public let type: GeofenceRegionType?
    public let latitude: Double?
    public let longitude: Double?
    public let radius: D?
    public let polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case latitude = "Lat"
        case longitude = "Lng"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.type = try container.decodeIfPresentIgnoringCase(GeofenceRegionType.self, forKey: .type)
            self.latitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: .latitude)
            self.longitude = try container.decodeIfPresentIgnoringCase(Double.self, forKey: .longitude)
            self.radius = try container.decodeIfPresentIgnoringCase(D.self, forKey: .radius)
            self.polygon = try container.decodeIfPresentIgnoringCase(String.self, forKey: .polygon)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}

public extension GeofenceRegion {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

public struct GeofenceRegionUpdate: Codable {
    
    public var type: GeofenceRegionType?
    public var latitude: Double?
    public var longitude: Double?
    public var radius: Distance?
    public var polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case latitude = "Lat"
        case longitude = "Lng"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(
        type: GeofenceRegionType? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        radius: Distance? = nil,
        polygon: String? = nil) {
        
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.polygon = polygon
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}
