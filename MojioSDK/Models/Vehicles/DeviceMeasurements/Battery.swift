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

public protocol BatteryModel: DeviceMeasurement {
    
    associatedtype T: TimePeriodModel
    
    var connected: Bool { get }
    var riskSeverity: RiskSeverity? { get }
    var lowVoltageDuration: T? { get }
    var highVoltageDuration: T? { get }
}

public struct Battery: BatteryModel {
    
    public typealias T = TimePeriod
    public typealias U = BatteryVoltageUnit
    
    //DeviceMeasurement
    public let baseUnit: U
    public let baseValue: Double
    public let unit: U
    public let value: Double
    public let timestamp: Date?
    
    public var connected: Bool = false
    
    // RiskSeverity
    public var riskSeverity: RiskSeverity? = nil
    public var lowVoltageDuration: T? = nil
    public var highVoltageDuration: T? = nil
    
    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case connected = "Connected"
        case riskSeverity = "RiskSeverity"
        case lowVoltageDuration = "LowVoltageDuration"
        case highVoltageDuration = "HighVoltageDuration"
    }
}

extension Battery {
    
    public init(from decoder: Decoder, with deviceMeasurements: DeviceMeasurements) throws {
        
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        let connected = try container.decodeIfPresentIgnoringCase(Bool.self, forKey: CodingKeys.connected) ?? false
        let riskSeverity = try container.decodeIfPresentIgnoringCase(RiskSeverity.self, forKey: CodingKeys.riskSeverity)
        let lowVoltageDuration = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.lowVoltageDuration)
        let highVoltageDuration = try container.decodeIfPresentIgnoringCase(TimePeriod.self, forKey: CodingKeys.highVoltageDuration)
        
        self.init(baseUnit: deviceMeasurements.baseUnit ?? .unknown, baseValue: deviceMeasurements.baseValue, unit: deviceMeasurements.unit ?? .unknown, value: deviceMeasurements.value, timestamp: deviceMeasurements.timestamp, connected: connected, riskSeverity: riskSeverity, lowVoltageDuration: lowVoltageDuration, highVoltageDuration: highVoltageDuration)
    }
    
    public func encode(with encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.connected, forKey: .connected)
        try container.encode(self.riskSeverity, forKey: .riskSeverity)
        try container.encode(self.lowVoltageDuration, forKey: .lowVoltageDuration)
        try container.encode(self.highVoltageDuration, forKey: .highVoltageDuration)
    }
}
