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

public protocol DistanceModel: DeviceMeasurement {
    init(baseUnit: U?, baseValue: Double, unit: U?, value: Double, timestamp: Date?)
}

public struct Distance: DistanceModel {
    
    public typealias U = DistanceUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case baseUnit = "BaseUnit"
        case baseValue = "BaseValue"
        case unit = "Unit"
        case value = "Value"
        case timestamp = "Timestamp"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.baseUnit = try container.decodeIfPresentIgnoringCase(U.self, forKey: CodingKeys.baseUnit) ?? .unknown
            self.baseValue = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.baseValue) ?? 0.0
            self.unit = try container.decodeIfPresentIgnoringCase(U.self, forKey: CodingKeys.unit) ?? .unknown
            self.value = try container.decodeIfPresentIgnoringCase(Double.self, forKey: CodingKeys.value) ?? 0.0
            self.timestamp = try container.decodeIfPresentIgnoringCase(Date.self, forKey: CodingKeys.timestamp)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

extension Distance {
    
    public init(baseUnit: U?, baseValue: Double, unit: U?, value: Double, timestamp: Date?) {
        self.baseUnit = baseUnit ?? .unknown
        self.baseValue = baseValue
        self.unit = unit ?? .unknown
        self.value = value
        self.timestamp = timestamp
    }
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        self.init(baseUnit: deviceMeasurements.baseUnit ?? .unknown, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit ?? .unknown, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp)
    }
    
    public func encode(with encoder: Encoder) throws {
        
    }
}
