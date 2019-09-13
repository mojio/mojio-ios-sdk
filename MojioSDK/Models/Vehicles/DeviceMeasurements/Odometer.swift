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

public protocol OdometerModel: DeviceMeasurement {
    var rolloverValue: Double { get }
}

public enum OdometerCodingKeys: String, CodingKey, CompoundWordStyle {
    case rolloverValue = "RolloverValue"
}

private protocol OdometerModelInitializer: OdometerModel {
    init(baseUnit: U?, baseValue: Double, unit: U?, value: Double, timestamp: Date?, rolloverValue: Double)
}

extension OdometerModelInitializer {
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        let rolloverValue = try container.decodeIfPresentIgnoringCase(Double.self, forKey: OdometerCodingKeys.rolloverValue) ?? 0
        
        self.init(
            baseUnit: deviceMeasurements.baseUnit,
            baseValue: deviceMeasurements.baseValue,
            unit: deviceMeasurements.unit,
            value: deviceMeasurements.value,
            timestamp: deviceMeasurements.timestamp,
            rolloverValue: rolloverValue)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: OdometerCodingKeys.self)
        try container.encode(self.rolloverValue, forKey: .rolloverValue)
    }
}

public struct Odometer: OdometerModel, OdometerModelInitializer {
    public typealias U = DistanceUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?

    public var rolloverValue: Double
    
    fileprivate init(baseUnit: DistanceUnit?, baseValue: Double, unit: DistanceUnit?, value: Double, timestamp: Date?, rolloverValue: Double) {
        self.baseUnit = baseUnit ?? .unknown
        self.baseValue = baseValue
        self.unit = unit ?? .unknown
        self.value = value
        self.timestamp = timestamp
        self.rolloverValue = rolloverValue
    }
}

public struct OdometerUpdate: OdometerModel, OdometerModelInitializer {
    
    public typealias U = DistanceUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
    
    public var rolloverValue: Double
    
    fileprivate init(baseUnit: DistanceUnit?, baseValue: Double, unit: DistanceUnit?, value: Double, timestamp: Date?, rolloverValue: Double) {
        self.init(baseUnit: baseUnit ?? .unknown, baseValue: baseValue, unit: unit ?? .unknown, value: value, timestamp: timestamp, rolloverValue: rolloverValue)
    }

    public init(baseUnit: DistanceUnit, baseValue: Double, unit: DistanceUnit, value: Double, timestamp: Date?, rolloverValue: Double) {
        self.baseUnit = baseUnit
        self.baseValue = baseValue
        self.unit = unit
        self.value = value
        self.timestamp = timestamp
        self.rolloverValue = rolloverValue
    }
}
