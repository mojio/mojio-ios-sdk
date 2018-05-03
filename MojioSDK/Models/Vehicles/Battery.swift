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

// Units in BatteryVoltageUnits
public struct Battery: DeviceMeasurement {
    
    //DeviceMeasurement
    public var baseUnit: String? = nil
    public var baseValue: Double = 0
    public var unit: String? = nil
    public var value: Double = 0
    public var timestamp: Date?  = nil
    
    //public var timeStamp: Date? = nil
    
    public var Connected: Bool = false
    
    // RiskSeverity
    public var RiskSeverity: String? = nil
    public var LowVoltageDuration: TimePeriod? = nil
    public var HighVoltageDuration: TimePeriod? = nil
    
    private enum CodingKeys: String, CodingKey {
        case Connected
        case RiskSeverity
        case LowVoltageDuration
        case HighVoltageDuration
    }
}

extension Battery {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let Connected = try container.decodeIfPresent(Bool.self, forKey: .Connected) ?? false
        let RiskSeverity = try container.decodeIfPresent(String.self, forKey: .RiskSeverity)
        let LowVoltageDuration = try container.decodeIfPresent(TimePeriod.self, forKey: .LowVoltageDuration)
        let HighVoltageDuration = try container.decodeIfPresent(TimePeriod.self, forKey: .HighVoltageDuration)
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, Connected: Connected, RiskSeverity: RiskSeverity, LowVoltageDuration: LowVoltageDuration, HighVoltageDuration: HighVoltageDuration)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.Connected, forKey: .Connected)
        try container.encode(self.RiskSeverity, forKey: .RiskSeverity)
        try container.encode(self.LowVoltageDuration, forKey: .LowVoltageDuration)
        try container.encode(self.HighVoltageDuration, forKey: .HighVoltageDuration)
    }
}

//public init() {}
