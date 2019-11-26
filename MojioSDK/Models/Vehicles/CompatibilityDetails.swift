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

public enum VehicleCompatibilityLevel: String, Codable {
    case full = "Full"
    case partial = "Partial"
    case minimum = "Minimum"
    case notCompatible = "NotCompatible"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = VehicleCompatibilityLevel(rawValue: label) ?? .unknown
    }
}

public protocol CompatibilityDetailsModel: Codable {
    var level: VehicleCompatibilityLevel? { get }
    var changed: Bool { get }
    var lastChecked: Date? { get }
}

public struct CompatibilityDetails: CompatibilityDetailsModel {
    
    public let level: VehicleCompatibilityLevel?
    public let changed: Bool
    public let lastChecked: Date?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case level = "Level"
        case changed = "Changed"
        case lastChecked = "LastChecked"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.lastChecked = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.lastChecked).flatMap { $0.dateFromISO }
            self.changed = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.changed) ?? false
            self.level = try container.decodeIfPresentIgnoringCase(VehicleCompatibilityLevel.self, forKey: CodingKeys.level)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.lastChecked, forKey: .lastChecked)
        try container.encodeIfPresent(self.changed, forKey: .changed)
        try container.encodeIfPresent(self.level, forKey: .level)
    }
}
