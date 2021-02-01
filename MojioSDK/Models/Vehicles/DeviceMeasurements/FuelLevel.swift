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

public protocol FuelLevelModel: DeviceMeasurement {
    var riskSeverity: RiskSeverity? { get }
}

public struct FuelLevel: FuelLevelModel {
    
    public typealias U = PercentageUnit
    
    // DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
    
    public var riskSeverity: RiskSeverity? = nil
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case riskSeverity = "RiskSeverity"
    }
}

extension FuelLevel {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        let riskSeverity = try container.decodeIfPresentIgnoringCase(RiskSeverity.self, forKey: CodingKeys.riskSeverity)
        
        self.init(baseUnit: deviceMeasurements.baseUnit ?? .unknown, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit ?? .unknown, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, riskSeverity: riskSeverity)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.riskSeverity, forKey: .riskSeverity)
    }
}
