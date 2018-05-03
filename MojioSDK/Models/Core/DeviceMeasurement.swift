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

enum DeviceMeasurementCodingKeys: String, CodingKey {
    case baseUnit = "baseUnit"
    case baseValue = "baseValue"
    case unit = "Unit"
    case value = "Value"
    case timestamp = "Timestamp"
}

public protocol DeviceMeasurement: Codable {
    
    typealias DeviceMeasurements = (baseUnit: String?, baseValue: Double, unit: String?, value: Double, timestamp: Date?)
    
    var baseUnit: String? { get }
    var baseValue: Double  { get }
    var unit: String? { get }
    var value: Double { get }
    var timestamp: Date? { get }
    
    init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws
    func encode(with encoder: Encoder) throws
}

extension DeviceMeasurement {
    
    init(with decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
        
        let baseUnit = try container.decodeIfPresent(String.self, forKey: .baseUnit)
        let baseValue = try container.decodeIfPresent(Double.self, forKey: .baseValue) ?? 0.0
        let unit = try container.decodeIfPresent(String.self, forKey: .unit)
        let value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0.0
        let timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp).flatMap { $0.dateFromIso8601 }
        
        let deviceMeasurements = DeviceMeasurements(baseUnit: baseUnit, baseValue: baseValue, unit: unit, value: value, timestamp: timestamp)
        
        try self.init(from: decoder, with: deviceMeasurements)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: DeviceMeasurementCodingKeys.self)
        
        try container.encode(self.baseUnit, forKey: .baseUnit)
        try container.encode(self.baseValue, forKey: .baseValue)
        try container.encode(self.unit, forKey: .unit)
        try container.encode(self.value, forKey: .value)
        try container.encode(self.timestamp, forKey: .timestamp)
        
        try self.encode(with: encoder)
    }
}
