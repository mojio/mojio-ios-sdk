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

public protocol GeneralBattery: DeviceMeasurement {
    
    associatedtype T: GeneralTimePeriod
    
    var connected: Bool { get }
    var riskSeverity: String? { get }
    var lowVoltageDuration: T? { get }
    var highVoltageDuration: T? { get }
}

// Units in BatteryVoltageUnits
public struct Battery: GeneralBattery {
    
    public typealias T = TimePeriod
    
    //DeviceMeasurement
    public let baseUnit: String?
    public let baseValue: Double
    public let unit: String?
    public let value: Double
    public let timestamp: Date?
    
    public var connected: Bool = false
    
    // RiskSeverity
    public var riskSeverity: String? = nil
    public var lowVoltageDuration: T? = nil
    public var highVoltageDuration: T? = nil
    
    public enum CodingKeys: String, CodingKey {
        case connected = "Connected"
        case riskSeverity = "RiskSeverity"
        case lowVoltageDuration = "LowVoltageDuration"
        case highVoltageDuration = "HighVoltageDuration"
    }
}

extension Battery {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let connected = try container.decodeIfPresent(Bool.self, forKey: .connected) ?? false
        let riskSeverity = try container.decodeIfPresent(String.self, forKey: .riskSeverity)
        let lowVoltageDuration = try container.decodeIfPresent(TimePeriod.self, forKey: .lowVoltageDuration)
        let highVoltageDuration = try container.decodeIfPresent(TimePeriod.self, forKey: .highVoltageDuration)
        
        self.init(baseUnit: deviceMeasurements.baseUnit, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, connected: connected, riskSeverity: riskSeverity, lowVoltageDuration: lowVoltageDuration, highVoltageDuration: highVoltageDuration)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.connected, forKey: .connected)
        try container.encode(self.riskSeverity, forKey: .riskSeverity)
        try container.encode(self.lowVoltageDuration, forKey: .lowVoltageDuration)
        try container.encode(self.highVoltageDuration, forKey: .highVoltageDuration)
    }
}
