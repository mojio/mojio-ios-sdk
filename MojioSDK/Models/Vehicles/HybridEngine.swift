/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2021 Copyright Moj.io Inc.
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

public enum HybridEngineMode: String, Codable, Equatable {
    case unknown = "Unknown"
    case combustion = "Combustion"
    case electric = "Electric"

    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = HybridEngineMode(rawValue: label) ?? .unknown
    }
}

public protocol HybridEngineModel: Codable {
    
    var timestamp: Date? { get }
    var mode: HybridEngineMode? { get }
    var combustionDuration: TimePeriod? { get }
    var electricDuration: TimePeriod? { get }
}

public struct HybridEngine: HybridEngineModel {
    
    public var timestamp: Date? = nil
    public var mode: HybridEngineMode? = nil
    public var combustionDuration: TimePeriod? = nil
    public var electricDuration: TimePeriod? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case hybridEngineMode = "HybridEngineMode"
        case hybridModeCombustionDuration = "HybridModeCombustionDuration"
        case hybridModeElectricDuration = "HybridModeElectricDuration"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.mode = try container.decodeIfPresentIgnoringCase(HybridEngineMode.self, forKey: CodingKeys.hybridEngineMode)
            self.combustionDuration = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.hybridModeCombustionDuration)
            self.electricDuration = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.hybridModeElectricDuration)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.mode, forKey: .hybridEngineMode)
        try container.encodeIfPresent(self.combustionDuration, forKey: .hybridModeCombustionDuration)
        try container.encodeIfPresent(self.electricDuration, forKey: .hybridModeElectricDuration)
    }
}
