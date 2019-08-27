/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2019 Copyright Moj.io Inc.
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

public enum EngineOilLevelWarning: String, Codable {
    case veryLow = "Very Low"
    case low = "Low"
    case high = "High"
    case unknown = "Unknown"
    
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = EngineOilLevelWarning(rawValue: label) ?? .unknown
    }
}

public protocol EngineOilModel: Codable {
    
    associatedtype EOT: EngineOilTemperatureModel
    
    var timestamp: Date? { get }
    var levelWarning: EngineOilLevelWarning? { get }
    var pressureLowWarning: Bool? { get }
    var temperature: EOT? { get }
}

public struct EngineOil: EngineOilModel {
    
    public typealias EOT = EngineOilTemperature
    
    public var timestamp: Date?
    public var levelWarning: EngineOilLevelWarning?
    public var pressureLowWarning: Bool?
    public var temperature: EngineOilTemperature? 
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case levelWarning = "EngineOilLevelWarning"
        case pressureLowWarning = "EngineOilPressureLowWarning"
        case temperature = "EngineOilTemperature"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.levelWarning = try container.decodeIfPresentIgnoringCase(EngineOilLevelWarning.self, forKey: CodingKeys.levelWarning)
            self.pressureLowWarning = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.pressureLowWarning)
            self.temperature = try container.decodeIfPresentIgnoringCase(EngineOilTemperature.self, forKey: CodingKeys.temperature)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.levelWarning, forKey: .levelWarning)
        try container.encodeIfPresent(self.pressureLowWarning, forKey: .pressureLowWarning)
        try container.encodeIfPresent(self.temperature, forKey: .temperature)
    }
}
