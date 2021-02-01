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

public enum HybridBatteryChargingStatus: String, Codable, Equatable {
    case unknown = "Unknown"
    case charging = "Charging"
    case neutral = "Neutral"
    case discharging = "Discharging"

    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = HybridBatteryChargingStatus(rawValue: label) ?? .unknown
    }
}

public protocol HybridBatteryModel: Codable {
    
    var timestamp: Date? { get }
    var voltage: Voltage? { get }
    var amperage: Amperage? { get }
    var chargeLevel: PercentageUnit? { get }
    var chargingStatus: HybridBatteryChargingStatus? { get }
}

public struct HybridBattery: HybridBatteryModel {
    
    public var timestamp: Date? = nil
    public var voltage: Voltage? = nil
    public var amperage: Amperage? = nil
    public var chargeLevel: PercentageUnit? = nil
    public var chargingStatus: HybridBatteryChargingStatus? = nil

    public enum CodingKeys: String, CodingKey, CompoundWordStyle {
        case timestamp = "Timestamp"
        case hybridBatteryVoltage = "HybridBatteryVoltage"
        case hybridBatteryCurrent = "HybridBatteryCurrent"
        case hybridBatteryChargeLevel = "HybridBatteryChargeLevel"
        case hybridBatteryChargingStatus = "HybridBatteryChargingStatus"
    }
    
    public init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: DynamicCodingKey.self)
            
            self.timestamp = try container.decodeIfPresentIgnoringCase(String.self, forKey: CodingKeys.timestamp).flatMap { $0.dateFromISO }
            self.voltage = try container.decodeIfPresentIgnoringCase(Voltage.self, forKey: CodingKeys.hybridBatteryVoltage)
            self.amperage = try container.decodeIfPresentIgnoringCase(Amperage.self, forKey: CodingKeys.hybridBatteryCurrent)
            self.chargeLevel = try container.decodeIfPresentIgnoringCase(PercentageUnit.self, forKey: CodingKeys.hybridBatteryChargeLevel)
            self.chargingStatus = try container.decodeIfPresentIgnoringCase(HybridBatteryChargingStatus.self, forKey: CodingKeys.hybridBatteryChargingStatus)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.voltage, forKey: .hybridBatteryVoltage)
        try container.encodeIfPresent(self.amperage, forKey: .hybridBatteryCurrent)
        try container.encodeIfPresent(self.chargeLevel, forKey: .hybridBatteryChargeLevel)
        try container.encodeIfPresent(self.chargingStatus, forKey: .hybridBatteryChargingStatus)
    }
}
