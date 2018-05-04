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

// Units are in PercentageUnits
public struct FuelLevel: DeviceMeasurement {
    
    // DeviceMeasurement
    public let baseUnit: String?
    public let baseValue: Double
    public let unit: String?
    public let value: Double
    public let timestamp: Date?
    
    public var RiskSeverity: String? = nil
    
    public enum CodingKeys: String, CodingKey {
        case RiskSeverity
    }
}

extension FuelLevel {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let RiskSeverity = try container.decodeIfPresent(String.self, forKey: .RiskSeverity)
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, RiskSeverity: RiskSeverity)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.RiskSeverity, forKey: .RiskSeverity)
    }
}
