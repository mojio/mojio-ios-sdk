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

public protocol TemperatureAlarmModel: Codable {
    var enabled: Bool? { get }
    var threshold: Double? { get }
}

public struct TemperatureAlarm: TemperatureAlarmModel {
    
    public let enabled: Bool?
    public let threshold: Double?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case threshold = "Threshold"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.threshold = try container.decodeIfPresent(Double.self, forKey: .threshold)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}

public struct TemperatureAlarmUpdate: Codable {
    public var enabled: Bool?
    public var threshold: Double?
    
    public enum CodingKeys: String, CodingKey {
        case enabled = "Enabled"
        case threshold = "Threshold"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.enabled, forKey: .enabled)
        try container.encodeIfPresent(self.threshold, forKey: .threshold)
    }
}
