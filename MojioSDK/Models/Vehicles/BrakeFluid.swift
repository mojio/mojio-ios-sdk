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

public enum FluidLevelWarning: String, Codable, Equatable {
    case noWarning = "NoWarning"
    case low = "Low"
    case unknown = "Unknown"

    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = FluidLevelWarning(rawValue: label) ?? .unknown
    }
}

public protocol BrakeFluidModel: Codable {
    
    var timestamp: Date? { get }
    var brakeFluidLevelWarning: FluidLevelWarning? { get }
}

public struct BrakeFluid: BrakeFluidModel {
    
    public var timestamp: Date? = nil
    public var brakeFluidLevelWarning: FluidLevelWarning? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case brakeFluidLevelWarning = "BrakeFluidLevelWarning"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.brakeFluidLevelWarning = try container.decodeIfPresentIgnoringCase(FluidLevelWarning.self, forKey: CodingKeys.brakeFluidLevelWarning)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.brakeFluidLevelWarning, forKey: .brakeFluidLevelWarning)
    }
}
