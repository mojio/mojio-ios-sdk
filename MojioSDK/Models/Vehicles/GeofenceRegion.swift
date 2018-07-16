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

public enum GeofenceRegionType: String, Codable {
    case circle = "Circle"
    case polygon = "Polygon"
}

public protocol GeofenceRegionModel: Codable {
    
    associatedtype D: DistanceModel
    
    var type: GeofenceRegionType? { get }
    var lat: Double? { get }
    var lng: Double? { get }
    var radius: D? { get }
    var polygon: String?  { get }
}

public struct GeofenceRegion: GeofenceRegionModel {
    
    public typealias D = Distance
    
    public let type: GeofenceRegionType?
    public let lat: Double?
    public let lng: Double?
    public let radius: D?
    public let polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.type = try container.decodeIfPresent(GeofenceRegionType.self, forKey: .type)
            self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
            self.lng = try container.decodeIfPresent(Double.self, forKey: .lng)
            self.radius = try container.decodeIfPresent(D.self, forKey: .radius)
            self.polygon = try container.decodeIfPresent(String.self, forKey: .polygon)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.lat, forKey: .lat)
        try container.encodeIfPresent(self.lng, forKey: .lng)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}

public struct GeofenceRegionUpdate: Codable {
    
    public var type: GeofenceRegionType?
    public var lat: Double?
    public var lng: Double?
    public var radius: Double?
    public var polygon: String?
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
        case polygon = "Polygon"
    }
    
    public init(
        type: GeofenceRegionType? = nil,
        lat: Double? = nil,
        lng: Double? = nil,
        radius: Double? = nil,
        polygon: String? = nil) {
        
        self.type = type
        self.lat = lat
        self.lng = lng
        self.radius = radius
        self.polygon = polygon
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.type, forKey: .type)
        try container.encodeIfPresent(self.lat, forKey: .lat)
        try container.encodeIfPresent(self.lng, forKey: .lng)
        try container.encodeIfPresent(self.radius, forKey: .radius)
        try container.encodeIfPresent(self.polygon, forKey: .polygon)
    }
}
