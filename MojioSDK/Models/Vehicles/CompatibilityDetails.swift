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

public struct CompatibilityDetails: Codable {
    
    public let level: VehicleCompatibilityLevel?
    public let changed: Bool
    public let lastChecked: Date?
    
    public enum CodingKeys: String, CodingKey {
        case level = "Level"
        case changed = "Changed"
        case lastChecked = "LastChecked"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.lastChecked = try container.decodeIfPresent(String.self, forKey: .lastChecked).flatMap { $0.dateFromIso8601 }
            self.changed = try container.decodeIfPresent(Bool.self, forKey: .changed) ?? false
            self.level = try container.decodeIfPresent(VehicleCompatibilityLevel.self, forKey: .level)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
