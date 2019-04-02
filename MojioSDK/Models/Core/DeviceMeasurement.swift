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
import SwiftDate

// Base Device Measurement
public enum DeviceMeasurementCodingKeys: String, CodingKey, CompoundWordStyle {
    case baseUnit = "BaseUnit"
    case baseValue = "BaseValue"
    case unit = "Unit"
    case value = "Value"
    case timestamp = "Timestamp"
}

public protocol DeviceMeasurement: Codable {
    
    associatedtype U: RawRepresentable, Codable
    
    typealias DeviceMeasurements = (baseUnit: U?, baseValue: Double, unit: U?, value: Double, timestamp: Date?)
    
    var baseUnit: U { get }
    var unit: U { get }
    
    var baseValue: Double  { get }
    var value: Double { get }
    var timestamp: Date? { get }
    
    init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws
    func encode(with encoder: Encoder) throws
}

public extension DeviceMeasurement {
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        
        let baseValue = try container.decodeIfPresentIgnoringCase(Double.self, forKey: DeviceMeasurementCodingKeys.baseValue) ?? 0.0
        
        let value = try container.decodeIfPresentIgnoringCase(Double.self, forKey: DeviceMeasurementCodingKeys.value) ?? 0.0
        let timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: DeviceMeasurementCodingKeys.timestamp).flatMap { $0.dateFromISO }
        
        let baseUnit = try container.decodeIfPresentIgnoringCase(U.self, forKey: DeviceMeasurementCodingKeys.baseUnit)
        let unit = try container.decodeIfPresentIgnoringCase(U.self, forKey: DeviceMeasurementCodingKeys.unit)
        
        let deviceMeasurements = DeviceMeasurements(baseUnit: baseUnit, baseValue: baseValue, unit: unit, value: value, timestamp: timestamp)
        
        try self.init(from: decoder, with: deviceMeasurements)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
        
        let baseUnit = self.baseUnit.rawValue as? String ?? ""
        let unit = self.unit.rawValue as? String ?? ""
        
        try container.encode(baseUnit, forKey: .baseUnit)
        try container.encode(self.baseValue, forKey: .baseValue)
        try container.encode(unit, forKey: .unit)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.timestamp, forKey: .timestamp)
        
        try self.encode(with: encoder)
    }
}
