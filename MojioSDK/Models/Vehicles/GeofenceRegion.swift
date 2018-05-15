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
    case unknown
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = GeofenceRegionType(rawValue: label) ?? .unknown
    }
}

public protocol GeneralGeofenceRegion {
    
    associatedtype D: GeneralDistance
    
    var type: GeofenceRegionType? { get }
    var lat: Double? { get }
    var lng: Double? { get }
    var radius: D? { get }
}

public struct GeofenceRegion: Codable, GeneralGeofenceRegion {
    
    public typealias D = Distance
    
    public var type: GeofenceRegionType? = nil
    public var lat: Double? = 0
    public var lng: Double? = 0
    public var radius: D? = nil
    
    public enum CodingKeys: String, CodingKey {
        case type = "Type"
        case lat = "Lat"
        case lng = "Lng"
        case radius = "Radius"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.type = try container.decodeIfPresent(GeofenceRegionType.self, forKey: .type)
            self.lat = try container.decodeIfPresent(Double.self, forKey: .lat)
            self.lng = try container.decodeIfPresent(Double.self, forKey: .lng)
            self.radius = try container.decodeIfPresent(D.self, forKey: .radius)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

