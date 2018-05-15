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

public enum BatteryStatus: String, Codable {
    case unknown = "Unknown"
    case charging = "Charging"
    case lowBattery = "LowBattery"
    case normal = "Normal"
}

public protocol BatteryModel: Codable {
    var level: Double? { get }
    var status: BatteryStatus? { get }
}

public struct Battery: BatteryModel {
    
    public let level: Double?
    public let status: BatteryStatus?
    
    public enum CodingKeys: String, CodingKey {
        case level = "Level"
        case status = "Status"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.level = try container.decodeIfPresent(Double.self, forKey: .level)
            self.status = try container.decodeIfPresent(BatteryStatus.self, forKey: .status)
        }
        catch {
            debugPrint(error)
            throw error
        }
    }
}
